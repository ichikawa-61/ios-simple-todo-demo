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
        helper.title = Constrains.Alert.addNewFolderTitle
        helper.message = Constrains.Alert.addNewFolderMessage
        helper.placeholder = Constrains.Alert.addNewFolderPlaceholder

        let alert = helper.createFolder(type: .add,
                                        delegate: topOf as! FormAlertHelperDelegate)
        topOf.present(alert, animated: true, completion: nil)
    }

    func showUpdate(index: Int, title: String, topOf: UIViewController) {

        let helper = FormAlertHelper()
        helper.title = Constrains.Alert.updateNewFolderTitle
        helper.message = Constrains.Alert.updateNewFolderMessage
        helper.placeholder = Constrains.Alert.updateNewFolderPlaceholder

        let alert = helper.createFolder(type: .update(index: index),
                                        title: title,
                                        delegate: topOf as! FormAlertHelperDelegate)

        topOf.present(alert, animated: true, completion: nil)
    }
}
