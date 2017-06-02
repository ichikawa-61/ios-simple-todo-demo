//
//  ToDoListViewControllerTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/02.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class ToDoListViewControllerTests: XCTestCase {

    var controller: ToDoListViewController!
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "ToDoListViewController", bundle: nil)
        controller = storyboard
            .instantiateViewController(
                withIdentifier: "ToDoListViewController")
            as? ToDoListViewController

        _ = controller?.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDefault_ForEditButton() {
        XCTAssertEqual(controller.editButton.title, "新規タスク")
    }

    func testNormalMode_ForEditButton() {
        controller.setEditing(false, animated: true)
        XCTAssertEqual(controller.editButton.title, "新規タスク")
    }

    func testEditMode_ForEditButton() {
        controller.setEditing(true, animated: true)
        XCTAssertEqual(controller.editButton.title, "すべて削除")
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
