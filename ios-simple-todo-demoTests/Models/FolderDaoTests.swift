//
//  FolderDaoTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ios_simple_todo_demo

class FolderDaoTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        FolderDao.deleteAll()
    }

    /// フォルダが登録できるか確認する
    func testAddFolder() {

        FolderDao.add(title: "タイトル")
        verifyFolder(folderID: 1, title: "タイトル")
    }

    /// フォルダが変更できるか確認する
    func testUpdateFolder() {

        FolderDao.add(title: "タイトル")
        let result = FolderDao.findAll().first
        result?.title = "タイトル2"
        
        FolderDao.update(folder: result!)
        
        verifyFolder(folderID: 1, title: "タイトル2")
    }

    /// フォルダが削除できるか確認する
    func testDeleteFolder() {

        FolderDao.add(title: "タイトル")
        FolderDao.delete(folderID: 1)
        verifyCount(count: 0)
    }

    /// すべてのフォルダが削除できるか確認する
    func testDeleteAllFolder() {
        
        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")

        FolderDao.deleteAll()
        verifyCount(count: 0)
    }
    
    /// フォルダが取得できるか？
    func testFindAllFolder() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")
        verifyCount(count: 3)
    }

    /// フォルダが古い順に取得できるか？
    func testFindAllFolder_ForOrder() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")

        let result = FolderDao.findAll()

        XCTAssertEqual("タイトル1", result[0].title)
        XCTAssertEqual("タイトル2", result[1].title)
        XCTAssertEqual("タイトル3", result[2].title)
    }

    /// 該当のフォルダが取得できるか？
    func testFindByIDFolder() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")

        let result = FolderDao.findByID(folderID: 2)
        XCTAssertEqual("タイトル2", result?.title)
    }
    
    /// 該当フォルダにToDoが登録できるか？
    /// check : 1フォルダに2個のToDoが存在する
    func testAddTask_ForOneFolder() {
        
        //Setup
        FolderDao.add(title: "フォルダ1")

        let folder = FolderDao.findAll().first
        let todoId1 = ToDoDao.add(title: "タスク1")
        let todoId2 = ToDoDao.add(title: "タスク2")
        
        if let todo1 = ToDoDao.findByID(todoID: todoId1),
            let todo2 = ToDoDao.findByID(todoID: todoId2) {
            folder?.todos.append(objectsIn: [todo1, todo2])
        }
        
        //Exercise
        FolderDao.update(folder: folder!)
        let result = FolderDao.findAllToDo(folderID: 1)
        
        //Verify
        XCTAssertEqual(result.count, 2)
    }
    
    /// 該当フォルダにToDoが登録できるか？
    /// check : フォルダ1 - 1フォルダに2個のToDoが存在する
    /// check : フォルダ2 - 1フォルダに1個のToDoが存在する
    func testAddTask_ForTwoFolder() {
        
        //Setup
        FolderDao.add(title: "フォルダ1")
        FolderDao.add(title: "フォルダ2")
        
        let folder1 = FolderDao.findAll().first
        let folder2 = FolderDao.findAll().last
        let todoId1 = ToDoDao.add(title: "タスク1")
        let todoId2 = ToDoDao.add(title: "タスク2")
        
        if let todo1 = ToDoDao.findByID(todoID: todoId1),
            let todo2 = ToDoDao.findByID(todoID: todoId2) {
            
            folder1?.todos.append(todo1)
            folder1?.todos.append(todo2)
            folder2?.todos.append(todo1)
        }
        FolderDao.update(folder: folder1!)
        FolderDao.update(folder: folder2!)

        //Exercise
        let result1 = FolderDao.findAllToDo(folderID: 1)
        let result2 = FolderDao.findAllToDo(folderID: 2)
        
        //Verify
        XCTAssertEqual(result1.count, 2)
        XCTAssertEqual(result2.count, 1)
    }
    
    /// 該当フォルダのToDoが削除できるか？
    /// check : 1フォルダにToDoが存在しない
    func testDeleteTask_ForOneFolder() {
        
        //Setup
        FolderDao.add(title: "フォルダ1")
        
        let folder = FolderDao.findAll().first
        let todoId1 = ToDoDao.add(title: "タスク1")
        let todoId2 = ToDoDao.add(title: "タスク2")
        
        if let todo1 = ToDoDao.findByID(todoID: todoId1),
            let todo2 = ToDoDao.findByID(todoID: todoId2) {
            folder?.todos.append(todo1)
            folder?.todos.append(todo2)
        }
        FolderDao.update(folder: folder!)

        //Exercise
        FolderDao.delete(folderID: 1)
        
        let result = FolderDao.findAllToDo(folderID: 1)
        
        //Verify
        XCTAssertEqual(result.count, 0)
    }

    
    //MARK : - Helper
    private func verifyFolder(folderID: Int, title: String) {

        let result = FolderDao.findAll()

        XCTAssertEqual(result.first?.folderID, folderID)

        if let title = result.first?.title {
            XCTAssertEqual(title, title)
        }

        XCTAssertNotNil(result.first?.date)
    }
    
    private func verifyCount(count: Int) {
        
        let result = FolderDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
