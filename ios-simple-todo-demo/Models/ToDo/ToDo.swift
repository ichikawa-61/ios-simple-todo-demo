//
//  ToDo.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import RealmSwift

final class ToDo: Object {

    dynamic var todoID = 0
    dynamic var title = ""
    dynamic var date: Date?

    override static func primaryKey() -> String? {
        return "todoID"
    }
}
