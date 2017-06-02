//
//  Constrains.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/02.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import STV_Extensions

struct Constrains {

    /// ツーバーに表示する文字列
    struct ToolBar {
        static let addFolderButton = "addFolderButton".localized()
        static let addTaskButton = "addTaskButton".localized()
        static let deleteAllButton = "deleteAllButton".localized()
    }

    /// アラートに表示する文字列
    struct Alert {

        ///新規フォルダ
        static let addNewFolderTitle = "addNewFolderTitle".localized()
        static let addNewFolderMessage = "addNewFolderMessage".localized()
        static let addNewFolderPlaceholder = "addNewFolderPlaceholder".localized()

        //フォルダ更新
        static let updateNewFolderTitle = "updateNewFolderTitle".localized()
        static let updateNewFolderMessage = "updateNewFolderMessage".localized()
        static let updateNewFolderPlaceholder = "updateNewFolderPlaceholder".localized()

        ///新規タスク
        static let addNewTaskTitle = "addNewTaskTitle".localized()
        static let addNewTaskMessage = "addNewTaskMessage".localized()
        static let addNewTaskPlaceholder = "addNewTaskPlaceholder".localized()

        //タスク更新
        static let updateNewTaskTitle = "updateNewTaskTitle".localized()
        static let updateNewTaskMessage = "updateNewTaskMessage".localized()
        static let updateNewTaskPlaceholder = "updateNewTaskPlaceholder".localized()

        /// 各種ボタン
        static let cancelButton = "cancelButtonTitle".localized()
        static let saveButton = "saveButtonTitle".localized()
        static let deleteAllButton = "deleteAllButton".localized()
    }
}
