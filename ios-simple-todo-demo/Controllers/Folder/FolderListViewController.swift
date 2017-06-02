//
//  FolderListViewController.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class FolderListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    fileprivate let dataSource = FolderListProvider()
    fileprivate let alert = FolderAlert()

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFolderList()
    }

    //MARK : - Action
    @IBAction func didTapEditFolder(_ sender: UIBarButtonItem) {

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
            Constrains.ToolBar.deleteAllButton : Constrains.ToolBar.addFolderButton
    }

    /// テーブルビューを設定する
    private func setupTableView() {
        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
    }

    /// フォルダ一覧を取得する
    func reloadFolderList() {
        dataSource.setFolders(folders: FolderDao.findAll())
        tableView.reloadData()
    }
}

//MARK : - AlertHelperDelegate
extension FolderListViewController: FormAlertHelperDelegate {

    /// フォルダの追加または、更新完了通知を受信したときの処理
    ///
    /// - Parameters:
    ///   - type: 更新タイプ(登録 or 更新)
    ///   - title: フォルダ名
    func addAndUpdate(type: FormAlertHelperType, title: String) {

        switch type {
        case .add:
            FolderDao.add(title: title)

        case .update(let index):
            let folder = dataSource.folder(index: index)
            folder.title = title
            FolderDao.update(folder: folder)
        }
        reloadFolderList()
        tableView.reloadData()
    }

    /// 全フォルダとそれに関連するメモを削除する
    func deleteAll() {
        FolderDao.deleteAll()
        ToDoDao.deleteAll()
        reloadFolderList()
        tableView.reloadData()
    }
}

//MARK : - UITableViewDelegate
extension FolderListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if isEditing {
            let folder = dataSource.folder(index: indexPath.row)
            alert.showUpdate(index: indexPath.row,
                              title: folder.title,
                              topOf: self)
            return
        }
        showMemoListViewController(indexPath: indexPath)
    }

    /// メモ一覧画面を表示する
    ///
    /// - Parameter indexPath: TableViewのIndexPath
    private func showMemoListViewController(indexPath: IndexPath) {

        let folder = dataSource.folder(index: indexPath.row)
        let vc = ToDoListViewController.configuredWith(folder: folder)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK : - FolderProviderDelegate
extension FolderListViewController: FolderListProviderDelegate {

    func deleteFolder(index: Int) {
        FolderDao.delete(folderID: index)
        ToDoDao.deleteAll(folderID: index)
        tableView.reloadData()
    }
}
