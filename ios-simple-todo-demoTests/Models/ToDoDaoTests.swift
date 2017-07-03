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
    }
    
    /// 登録できるか確認する
    func testAddToDo() {

        ToDoDao.add(title: "タイトル")
        verify(todoID: 1, title: "タイトル")
    }
    
    /// 変更できるか確認する
    func testUpdateToDo() {
        
        ToDoDao.add(title: "タイトル")
        let result = ToDoDao.findAll().first
        result?.title = "タイトル2"
        ToDoDao.update(todo: result!)
        verify(todoID: 1, title: "タイトル2")
    }
    
    /// 削除できるか確認する
    func testDeleteToDo() {
        
        ToDoDao.add(title: "タイトル")
        ToDoDao.delete(todoID: 1)
        verifyCount(count: 0)
    }
    
    /// 該当のToDoが取得できるか確認する
    func testFindToDo() {
        
        ToDoDao.add(title: "タイトル1")
        ToDoDao.add(title: "タイトル2")
        ToDoDao.add(title: "タイトル3")
        verify(todoID: 2, title: "タイトル2")
    }
    
    /// すべてのToDoが取得できるか確認する
    func testFindAllToDo() {
        
        ToDoDao.add(title: "タイトル1")
        ToDoDao.add(title: "タイトル2")
        ToDoDao.add(title: "タイトル3")
        verifyCount(count: 3)
    }

    //MARK : - Helper
    private func verify(todoID: Int, title: String) {
        
        let result = ToDoDao.findByID(todoID: todoID)
        
        XCTAssertEqual(result?.todoID, todoID)
        
        if let title = result?.title {
            XCTAssertEqual(title, title)
        }
        
        XCTAssertNotNil(result?.date)
    }
    
    private func verifyCount(count: Int) {
        
        let result = ToDoDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
