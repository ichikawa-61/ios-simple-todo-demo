//
//  FolderDao.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import RealmSwift
import STV_Extensions

final class FolderDao {

    static let dao = RealmDaoHelper<Folder>()

    /// フォルダを追加する
    ///
    /// - Parameter title: フォルダタイトル
    static func add(title: String) {

        let object = Folder()
        object.folderID = FolderDao.dao.newId()!
        object.title = title
        object.date = Date().now()
        object.count = 0
        FolderDao.dao.add(data: object)
    }

    /// フォルダを更新する
    ///
    /// - Parameter folder: フォルダ
    static func update(folder: Folder) {

        guard let target = dao.findFirst(key: folder.folderID as AnyObject) else {
            return
        }

        let object = Folder()
        object.folderID = target.folderID
        object.title = folder.title
        object.date = Date().now()
        object.count = folder.count
        dao.update(data: object)
    }

    /// フォルダを削除する
    ///
    /// - Parameter folderID: フォルダID
    static func delete(folderID: Int) {

        guard let target = dao.findFirst(key: folderID as AnyObject) else {
            return
        }
        ToDoDao.deleteAll(folderID: target.folderID)
        dao.delete(data: target)
    }

    /// フォルダをすべて削除する
    static func deleteAll() {
        ToDoDao.deleteAll()
        dao.deleteAll()
    }

    /// 該当のフォルダを取得する
    ///
    /// - Parameter folderID: フォルダID
    /// - Returns: フォルダ
    static func findByID(folderID: Int) -> Folder? {
        guard let object = dao.findFirst(key: folderID as AnyObject) else {
            return nil
        }
        return object
    }

    /// フォルダをすべて取得する
    ///
    /// - Returns: フォルダ一覧
    static func findAll() -> [Folder] {
        let objects = FolderDao.dao.findAll()
            .sorted(byKeyPath: "date", ascending: false)
        return objects.map { Folder(value: $0) }
    }
}
