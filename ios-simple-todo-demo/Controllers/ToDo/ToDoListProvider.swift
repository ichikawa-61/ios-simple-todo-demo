//
//  ToDoListProvider.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol ToDoListProviderDelegate: class {
    func deleteToDo(todoID: Int)
}

final class ToDoListProvider: NSObject {

    //MARK : - Properties    
    fileprivate var todos = [ToDo]()
    weak var delegate: ToDoListProviderDelegate?

    //MARK : - Public Methods
    /// ToDo一覧を設定する
    ///
    /// - Parameter todos: メモ一覧
    func set(todos: [ToDo]) {
        self.todos = todos
    }

    /// 該当のToDoを取得する
    ///
    /// - Parameter index: TableViewのインデックス
    /// - Returns: メモ
    func todo(index: Int) -> ToDo {

        guard index < todos.count else {
            fatalError("memosの要素数を超えました。")
        }
        return todos[index]
    }

    /// ToDo数を取得する
    ///
    /// - Returns: メモ数
    func count() -> Int {
        return todos.count
    }
}

//MARK : - UITableViewDataSource
extension ToDoListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView
            .dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier,
                                 for: indexPath) as? ToDoTableViewCell
        cell?.todo = todo(index: indexPath.row)
        return cell!
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == UITableViewCellEditingStyle.delete {

            let item = todo(index: indexPath.row)
            todos.remove(at: indexPath.row)
            delegate?.deleteToDo(todoID: item.todoID)
        }
    }
}
