//
//  Folder.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import RealmSwift

final class Folder: Object {

    dynamic var folderID = 0
    dynamic var title = ""
    dynamic var date: Date?
    let todos = List<ToDo>()
    
    /// タスクの件数(表示専用）
    var taskCount: String {
        return "\(todos.count)"
    }

    override static func primaryKey() -> String? {
        return "folderID"
    }
}
