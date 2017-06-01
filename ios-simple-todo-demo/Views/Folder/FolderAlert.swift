//
//  FolderAlert.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class FolderAlert: NSObject, FormAlertable {

    func showCreate(topOf: UIViewController) {

        let helper = FormAlertHelper()
        helper.title = "新規フォルダ"
        helper.message = "このフォルダの名前を入力してください。"
        helper.placeholder = "このフォルダの名前を入力してください。"

        let alert = helper.createFolder(type: .add,
                                        delegate: topOf as! FormAlertHelperDelegate)
        topOf.present(alert, animated: true, completion: nil)
    }

    func showUpdate(index: Int, title: String, topOf: UIViewController) {

        let helper = FormAlertHelper()
        helper.title = "フォルダの名前を変更"
        helper.message = "このフォルダの新しい名前を入力してください。"
        helper.placeholder = ""

        let alert = helper.createFolder(type: .update(index: index),
                                        title: title,
                                        delegate: topOf as! FormAlertHelperDelegate)

        topOf.present(alert, animated: true, completion: nil)
    }
}
