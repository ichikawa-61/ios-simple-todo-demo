//
//  FolderTableViewCellTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class FolderTableViewCellTests: XCTestCase {

    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: FolderTableViewCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "FolderListViewController", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "FolderListViewController")
            as! FolderListViewController

        _ = controller.view

        tableView = controller.tableView
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(
            withIdentifier: "FolderTableViewCell",
            for: IndexPath(row: 0, section: 0)) as! FolderTableViewCell
    }
    
    override func tearDown() {
        super.tearDown()
    }

    /// カウントが1以上のとき
    func testSetCountLabel() {

        let folder = Folder()
        folder.count = 10
        folder.title = "タイトル"
        folder.date = Date().now()
        cell.folder = folder

        XCTAssertEqual(cell.titleLabel.text, "タイトル")
        XCTAssertEqual(cell.countLabel.text, "10")
    }

    /// カウントが0のとき
    func testSetCountLabel_WhenCount0() {

        let folder = Folder()
        folder.count = 0
        folder.title = "タイトル"
        folder.date = Date().now()
        cell.folder = folder

        XCTAssertEqual(cell.titleLabel.text, "タイトル")
        XCTAssertEqual(cell.countLabel.text, "0")
    }
}

extension FolderTableViewCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
