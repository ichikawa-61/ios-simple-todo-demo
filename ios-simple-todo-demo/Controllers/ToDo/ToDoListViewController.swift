//
//  ToDoListViewController.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    fileprivate let dataSource = ToDoListProvider()
    fileprivate let alert = ToDoAlert()
    fileprivate var folder: Folder!

    /// ToDo一覧画面のインスタンスを取得する
    ///
    /// - Parameter folder: フォルダ
    /// - Returns: ToDo一覧画面のインスタンス
    static func configuredWith(folder: Folder) -> ToDoListViewController {

        let vc = UIStoryboard
            .viewController(storyboardName: ToDoListViewController.className,
                            identifier: ToDoListViewController.className)
            as? ToDoListViewController
        vc?.folder = folder
        vc?.title = folder.title
        return vc!
    }

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadToDoList()
    }

    //MARK : - Action
    @IBAction func didTapEditToDo(_ sender: UIBarButtonItem) {

        if tableView.isEditing {
            alert.showDeleteAll(topOf: self)
        } else {
            alert.showCreate(topOf: self)
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        setupToolBar(isEditing: editing)
    }

    /// ナビゲーションバーを設定する
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.hideBackButtonTitle()
    }

    /// ツールバーを設定する
    ///
    /// - Parameter isEditing: 編集モードか？
    private func setupToolBar(isEditing: Bool) {
        editButton.title = isEditing ?
            Constrains.ToolBar.deleteAllButton : Constrains.ToolBar.addTaskButton
    }

    /// テーブルビューを設定する
    private func setupTableView() {
        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
    }

    /// タスク一覧を取得する
    func reloadToDoList() {
        dataSource.setToDos(todos: ToDoDao.findAll(folderID: folder.folderID))
        tableView.reloadData()
    }

    /// タスクの件数を更新する
    fileprivate func updateToDoCount() {

        let todoCount = dataSource.count()
        let updateFolder = folder
        updateFolder?.count = todoCount
        FolderDao.update(folder: updateFolder!)
    }

}

//MARK : - AlertHelperDelegate
extension ToDoListViewController: FormAlertHelperDelegate {

    /// フォルダの追加または、更新完了通知を受信したときの処理
    ///
    /// - Parameters:
    ///   - type: 更新タイプ(登録 or 更新)
    ///   - title: フォルダ名
    func addAndUpdate(type: FormAlertHelperType, title: String) {

        switch type {
        case .add:
            ToDoDao.add(folderID: folder.folderID, title: title)

        case .update(let index):
            let todo = dataSource.todo(index: index)
            todo.title = title
            ToDoDao.update(todo: todo)
        }

        reloadToDoList()
        updateToDoCount()
        tableView.reloadData()
    }

    /// 全フォルダとそれに関連するメモを削除する
    func deleteAll() {
        ToDoDao.deleteAll()
        reloadToDoList()
        updateToDoCount()
        tableView.reloadData()
    }
}

//MARK : - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if isEditing {
            let folder = dataSource.todo(index: indexPath.row)
            alert.showUpdate(index: indexPath.row,
                             title: folder.title,
                             topOf: self)
            return
        }
    }
}

//MARK : - ToDoListProviderDelegate
extension ToDoListViewController: ToDoListProviderDelegate {

    func deleteToDo(todoID: Int) {
        ToDoDao.delete(todoID: todoID)
        updateToDoCount()
        tableView.reloadData()
    }
}
