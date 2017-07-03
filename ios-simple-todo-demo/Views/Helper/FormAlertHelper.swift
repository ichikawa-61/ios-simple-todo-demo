//
//  FolderAlertHelper.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

enum FormAlertHelperType {
    case add
    case update(index: Int)
}

protocol FormAlertHelperDelegate: class {
    func addAndUpdate(type: FormAlertHelperType, title: String)
    func deleteAll()
}

final class FormAlertHelper: NSObject {

    weak var delegate: FormAlertHelperDelegate?
    fileprivate var alert: UIAlertController!

    var title: String?
    var message: String?
    var placeholder: String?

    /// 新規作成用のダイアログを作成する
    ///
    /// - Parameters:
    ///   - type: 更新タイプ（登録 or 更新)
    ///   - title: タイトル
    ///   - delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func createFolder(type: FormAlertHelperType,
                      title: String = "",
                      delegate: FormAlertHelperDelegate) -> UIAlertController {

        alert = UIAlertController(title: self.title,
                                  message: message,
                                  preferredStyle: .alert)

        self.delegate = delegate

        let cancelAction = UIAlertAction(title: Constrains.Alert.cancelButton,
                                         style: .cancel,
                                         handler: nil)

        let saveAction = UIAlertAction(title: Constrains.Alert.saveButton,
                                       style: .default) { _ in

            if let textField = self.alert.textFields?.first {

                if let folderName = textField.text {
                    self.delegate?.addAndUpdate(type: type, title: folderName)
                }
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        alert.addTextField { [weak self] (textField) in

            textField.placeholder = self?.placeholder
            textField.text = title
            textField.delegate = self

            if let saveButton = self?.alert.actions.last {
                saveButton.isEnabled = false
            }
        }
        return alert
    }

    /// 削除用のアクションシートを作成する
    ///
    /// - Parameter delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func deleateFolder(delegate: FormAlertHelperDelegate) -> UIAlertController {

        alert = UIAlertController(title: nil,
                                  message: nil,
                                  preferredStyle: .actionSheet)

        self.delegate = delegate

        let cancelAction = UIAlertAction(title: Constrains.Alert.cancelButton,
                                         style: .cancel,
                                         handler: nil)

        let deleteAction = UIAlertAction(title: Constrains.Alert.deleteAllButton,
                                         style: .destructive) { _ in
            self.delegate?.deleteAll()
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        return alert
    }
}

// MARK: - UITextFieldDelegate
extension FormAlertHelper: UITextFieldDelegate {

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
