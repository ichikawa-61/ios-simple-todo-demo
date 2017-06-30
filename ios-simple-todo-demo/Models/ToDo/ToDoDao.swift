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
    /// - Parameters:
    ///   - folderID: フォルダID
    ///   - title:  タイトル
    static func add(folderID: Int, title: String) {

        let object = ToDo()
        object.todoID = ToDoDao.dao.newId()!
        object.folderID = folderID
        object.title = title
        object.date = Date().now()
        ToDoDao.dao.add(data: object)
    }

    /// ToDoを更新する
    ///
    /// - Parameter todo: ToDo
    static func update(todo: ToDo) {

        guard let target = dao
            .findFirst(key: todo.todoID as AnyObject) else {
                return
        }

        let object = ToDo()
        object.todoID = target.todoID
        object.folderID = target.folderID
        object.title = todo.title
        object.date = Date().now()
        dao.update(data: object)
    }

    /// ToDoを削除する
    ///
    /// - Parameter todoID: ToDo-ID
    static func delete(todoID: Int) {

        guard let target = dao
            .findFirst(key: todoID as AnyObject) else {
                return
        }
        dao.delete(data: target)
    }

    /// フォルダ内のToDoをすべて削除する
    ///
    /// - Parameter folderID: フォルダID
    static func deleteAll(folderID: Int) {
        dao.deleteAll(key: "folderID" as AnyObject, value: folderID as AnyObject)
    }

    /// メモをすべて削除する
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

    /// 該当のToDo一覧を取得する
    ///
    /// - Parameters:
    ///   - folderID: フォルダID
    /// - Returns: ToDo一覧
    static func findAll(folderID: Int) -> [ToDo] {
        let objects = ToDoDao.dao
            .findAll(key: "folderID" as AnyObject, value: folderID as AnyObject)
            .sorted(byKeyPath: "date", ascending: false)
        return objects.map { ToDo(value: $0) }
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
