//
//  ToDoTableViewCellTests.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/02.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_todo_demo

class ToDoTableViewCellTests: XCTestCase {

 /*
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ToDoTableViewCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "ToDoListViewController", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "ToDoListViewController")
            as! ToDoListViewController

        _ = controller.view

        tableView = controller.tableView
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(
            withIdentifier: "ToDoTableViewCell",
            for: IndexPath(row: 0, section: 0)) as! ToDoTableViewCell
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSetToDo() {

        let todo = ToDo()
        todo.title = "タスク名"
        todo.date = string2Date(dateString: "2017/01/01 10:10:10")
        cell.todo = todo

        XCTAssertEqual(cell.dateLabel.text, "2017/01/01")
    }

    //MARK : - Helper
    private func string2Date(dateString: String) -> Date{

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: dateString)!
    }
 */
}

extension ToDoTableViewCellTests {

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
