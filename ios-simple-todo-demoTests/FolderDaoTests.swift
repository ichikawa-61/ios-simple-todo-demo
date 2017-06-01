//
//  FolderDaoTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class FolderDaoTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        FolderDao.deleteAll()
    }

    /// 登録できるか確認する
    func testAddMemo() {

        FolderDao.add(title: "タイトル")
        verifyMemo(folderID: 1, title: "タイトル")
    }

    /// 変更できるか確認する
    func testUpdateMemo() {

        FolderDao.add(title: "タイトル")

        let result = FolderDao.findAll().first
        result?.title = "タイトル2"
        FolderDao.update(folder: result!)
        verifyMemo(folderID: 1, title: "タイトル2")
    }

    /// 削除できるか確認する
    func testDeleteMemo() {

        FolderDao.add(title: "タイトル")
        FolderDao.delete(folderID: 1)
        verifyCount(count: 0)
    }

    /// メモが取得できるか？
    func testFindAllMemo() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")
        verifyCount(count: 3)
    }

    /// メモが古い順に取得できるか？
    func testFindAllMemo_ForOrder() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")

        let result = FolderDao.findAll()

        XCTAssertEqual("タイトル1", result[0].title)
        XCTAssertEqual("タイトル2", result[1].title)
        XCTAssertEqual("タイトル3", result[2].title)
    }

    /// 該当のメモが取得できるか？
    func testFindByIDMemo() {

        FolderDao.add(title: "タイトル1")
        FolderDao.add(title: "タイトル2")
        FolderDao.add(title: "タイトル3")

        let result = FolderDao.findByID(folderID: 2)
        XCTAssertEqual("タイトル2", result?.title)
    }

    //MARK : - Helper
    private func verifyMemo(folderID: Int, title: String) {

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
