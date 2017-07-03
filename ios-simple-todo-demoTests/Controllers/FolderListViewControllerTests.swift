//
//  FolderListViewControllerTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/02.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class FolderListViewControllerTests: XCTestCase {

    var controller: FolderListViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "FolderListViewController", bundle: nil)
        controller = storyboard
            .instantiateViewController(
                withIdentifier: "FolderListViewController")
            as? FolderListViewController

        _ = controller?.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDefault_ForEditButton() {
        XCTAssertEqual(controller.editButton.title, "新規フォルダ")
    }

    func testNormalMode_ForEditButton() {
        controller.setEditing(false, animated: true)
        XCTAssertEqual(controller.editButton.title, "新規フォルダ")
    }

    func testEditMode_ForEditButton() {
        controller.setEditing(true, animated: true)
        XCTAssertEqual(controller.editButton.title, "すべて削除")
    }

    func testNavigationBarTitle() {
        let title = controller.navigationItem.title
        XCTAssertEqual(title, "フォルダ")
    }

    func testNavigationBarBackButtonTitle_None() {
        let title = controller.navigationItem.backBarButtonItem?.title
        XCTAssertEqual(title, "")
    }

    func testNavigationBarEditButtonTitle_Edit() {
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_Complate() {
        controller.setEditing(true, animated: true)
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "完了")
    }
}
