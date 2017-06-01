//
//  FolderAlertHelper.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

enum FolderAlertHelperType {
    case add
    case update(index: Int)
}

protocol FolderAlertHelperDelegate: class {
    func setFolder(type: FolderAlertHelperType, folderName: String)
    func deleteAll()
}

final class FolderAlertHelper: NSObject {

    weak var delegate: FolderAlertHelperDelegate?
    fileprivate var alert: UIAlertController!

    /// 新規フォルダー作成用のダイアログを作成する
    ///
    /// - Parameters:
    ///   - type: 更新タイプ（登録 or 更新)
    ///   - title: ダイアログのタイトル
    ///   - message: ダイアログのメッセージ
    ///   - folderName: フォルダ名
    ///   - delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func createFolder(type: FolderAlertHelperType,
                      title: String,
                      message: String,
                      folderName: String = "",
                      delegate: FolderAlertHelperDelegate) -> UIAlertController {

        alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)

        self.delegate = delegate

        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: .cancel,
                                         handler: nil)

        let saveAction = UIAlertAction(title: "保存",
                                       style: .default) { _ in

                                        if let textField = self.alert.textFields?.first {

                                            if let folderName = textField.text {
                                                self.delegate?.setFolder(type: type, folderName: folderName)
                                            }
                                        }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        alert.addTextField { [weak self] (textField) in

            textField.placeholder = "このフォルダの名前を入力してください。"
            textField.text = folderName
            textField.delegate = self

            if let saveButton = self?.alert.actions.last {
                saveButton.isEnabled = false
            }
        }
        return alert
    }

    /// フォルダ削除用のアクションシートを作成する
    ///
    /// - Parameter delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func deleateFolder(delegate: FolderAlertHelperDelegate) -> UIAlertController {

        alert = UIAlertController(title: nil,
                                  message: nil,
                                  preferredStyle: .actionSheet)

        self.delegate = delegate

        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: .cancel,
                                         handler: nil)

        let deleteAction = UIAlertAction(title: "削除",
                                         style: .destructive) { _ in
                                            self.delegate?.deleteAll()
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        return alert
    }
}

// MARK: - UITextFieldDelegate
extension FolderAlertHelper: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if let saveButton = alert.actions.last {

            let textFieldText = (textField.text ?? "") as NSString
            let textAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            saveButton.isEnabled = textAfterUpdate.characters.count >= 1
        }
        
        return true
    }
}
