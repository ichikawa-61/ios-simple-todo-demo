//
//  ToDoDao.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import RealmSwift

final class ToDoDao {

    static let dao = RealmDaoHelper<ToDo>()

    /// ToDoを登録する
    ///
    /// - Parameter title: タイトル
    /// - Returns: ToDo-ID
    @discardableResult
    static func add(title: String) -> Int {

        let object = ToDo()
        object.todoID = ToDoDao.dao.newId()!
        object.title = title
        object.date = Date().now()
        ToDoDao.dao.add(data: object)
        
        return object.todoID
    }

    /// 該当のToDoを更新する
    ///
    /// - Parameter todo: ToDo
    static func update(todo: ToDo) {

        guard let target = dao
            .findFirst(key: todo.todoID as AnyObject) else {
                return
        }

        let object = ToDo()
        object.todoID = target.todoID
        object.title = todo.title
        object.date = Date().now()
        dao.update(data: object)
    }

    /// 該当のToDoを削除する
    ///
    /// - Parameter todoID: ToDo-ID
    static func delete(todoID: Int) {

        guard let target = dao
            .findFirst(key: todoID as AnyObject) else {
                return
        }
        dao.delete(data: target)
    }

    /// すべてのToDoを削除する
    static func deleteAll() {
        dao.deleteAll()
    }

    /// 該当のToDoを取得する
    ///
    /// - Parameter todoID: ToDo-ID
    /// - Returns: ToDo
    static func findByID(todoID: Int) -> ToDo? {
        guard let object = dao
            .findFirst(key: todoID as AnyObject) else {
                return nil
        }
        return object
    }

    /// すべてのToDoを取得する
    ///
    /// - Returns: ToDo一覧
    static func findAll() -> [ToDo] {
        let objects = ToDoDao.dao
            .findAll()
            .sorted(byKeyPath: "date", ascending: false)
        return objects.map { ToDo(value: $0) }
    }
}
