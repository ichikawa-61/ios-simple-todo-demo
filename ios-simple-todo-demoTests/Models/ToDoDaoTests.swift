//
//  ToDoDaoTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class ToDoDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        FolderDao.deleteAll()
        ToDoDao.deleteAll()
    }
    
    /// 登録できるか確認する
    func testAddFolder() {

        ToDoDao.add(folderID: 1, title: "タイトル")
        verifyFolder(folderID: 1, todoID: 1, title: "タイトル")
    }

    /// 変更できるか確認する
    func testUpdateFolder() {

        ToDoDao.add(folderID: 1, title: "タイトル")

        let result = ToDoDao.findAll().first
        result?.title = "タイトル2"
        ToDoDao.update(todo: result!)
        verifyFolder(folderID: 1, todoID: 1, title: "タイトル2")
    }

    /// 削除できるか確認する
    func testDeleteFolder() {

        ToDoDao.add(folderID: 1, title: "タイトル")
        ToDoDao.delete(todoID: 1)
        verifyCount(folderID: 1, count: 0)
    }

    /// フォルダが取得できるか？
    func testFindAllFolder() {

        ToDoDao.add(folderID: 1, title: "タイトル1")
        ToDoDao.add(folderID: 2, title: "タイトル1")
        ToDoDao.add(folderID: 1, title: "タイトル3")
        ToDoDao.add(folderID: 1, title: "タイトル4")
        verifyCount(folderID: 1, count: 3)
    }

    /// フォルダが古い順に取得できるか？
    func testFindAllFolder_ForOrder() {

        ToDoDao.add(folderID: 1, title: "タイトル1")
        ToDoDao.add(folderID: 1, title: "タイトル2")
        ToDoDao.add(folderID: 1, title: "タイトル3")

        let result = ToDoDao.findAll()

        XCTAssertEqual("タイトル1", result[0].title)
        XCTAssertEqual("タイトル2", result[1].title)
        XCTAssertEqual("タイトル3", result[2].title)
    }

    /// 該当のフォルダが取得できるか？
    func testFindByIDFolder_Count() {

        ToDoDao.add(folderID: 1, title: "タイトル1")
        ToDoDao.add(folderID: 2, title: "タイトル2")
        ToDoDao.add(folderID: 1, title: "タイトル3")
        ToDoDao.add(folderID: 1, title: "タイトル4")

        verifyCount(folderID: 1, count: 3)
    }

    /// 該当のフォルダが取得できるか？
    func testFindByIDFolder() {

        ToDoDao.add(folderID: 1, title: "タイトル1")
        ToDoDao.add(folderID: 2, title: "タイトル2")
        ToDoDao.add(folderID: 1, title: "タイトル3")
        ToDoDao.add(folderID: 2, title: "タイトル4")

        verifyCount(folderID: 1, count: 2)
    }

    //MARK : - Helper
    private func verifyFolder(folderID: Int, todoID: Int, title: String) {

        let result = ToDoDao.findAll()

        XCTAssertEqual(result.first?.folderID, folderID)
        XCTAssertEqual(result.first?.todoID, todoID)

        if let title = result.first?.title {
            XCTAssertEqual(title, title)
        }

        XCTAssertNotNil(result.first?.date)
    }

    private func verifyCount(folderID: Int, count: Int) {
        
        let result = ToDoDao.findAll(key: "folderID", folderID: folderID)
        XCTAssertEqual(result.count, count)
    }    
}
