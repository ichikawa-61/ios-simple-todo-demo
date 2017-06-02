//
//  ToDoAlert.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class ToDoAlert: NSObject, FormAlertable {

    func showCreate(topOf: UIViewController) {

        let helper = FormAlertHelper()
        helper.title = Constrains.Alert.addNewTaskTitle
        helper.message = Constrains.Alert.addNewTaskMessage
        helper.placeholder = Constrains.Alert.addNewTaskPlaceholder

        let alert = helper.createFolder(type: .add,
                                        delegate: topOf as! FormAlertHelperDelegate)
        topOf.present(alert, animated: true, completion: nil)

    }

    func showUpdate(index: Int, title: String, topOf: UIViewController) {

        let helper = FormAlertHelper()
        helper.title = Constrains.Alert.updateNewTaskTitle
        helper.message = Constrains.Alert.updateNewTaskMessage
        helper.placeholder = Constrains.Alert.updateNewFolderPlaceholder

        let alert = helper.createFolder(type: .update(index: index),
                                        title: title,
                                        delegate: topOf as! FormAlertHelperDelegate)

        topOf.present(alert, animated: true, completion: nil)
    }
}
