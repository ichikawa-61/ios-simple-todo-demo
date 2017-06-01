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
    fileprivate var alert: UIAlertController!
    fileprivate let dataSource = FolderListProvider()

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
            showAllDeleteFolderAlert()
        } else {
            showCreateFolderAlert()
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
            "すべて削除" : "新規作成"
    }

    /// テーブルビューを設定する
    private func setupTableView() {
        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
    }

    /// フォルダの新規作成ダイアログを表示する
    private func showCreateFolderAlert() {

        alert = FolderAlertHelper()
            .createFolder(type: .add,
                          title: "新規フォルダ",
                          message: "このフォルダの名前を入力してください。",
                          delegate: self)
        present(alert, animated: true, completion: { [weak self] in
            self?.alert = nil
        })
    }

    /// フォルダ全削除用のダイアログを表示する
    private func showAllDeleteFolderAlert() {

        alert = FolderAlertHelper().deleateFolder(delegate: self)
        present(alert, animated: true, completion: { [weak self] in
            self?.alert = nil
        })
    }

    /// フォルダ一覧を取得する
    func reloadFolderList() {
        dataSource.setFolders(folders: FolderDao.findAll())
        tableView.reloadData()
    }
}

//MARK : - AlertHelperDelegate
extension FolderListViewController: FolderAlertHelperDelegate {

    /// フォルダの追加または、更新完了通知を受信したときの処理
    ///
    /// - Parameters:
    ///   - type: 更新タイプ(登録 or 更新)
    ///   - folderName: フォルダ名
    func setFolder(type: FolderAlertHelperType, folderName: String) {

        switch type {
        case .add:
            FolderDao.add(title: folderName)

        case .update(let index):
            let folder = dataSource.folder(index: index)
            folder.title = folderName
            FolderDao.update(folder: folder)
        }
        reloadFolderList()
        tableView.reloadData()
    }

    /// 全フォルダとそれに関連するメモを削除する
    func deleteAll() {
        FolderDao.deleteAll()
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
            showUpdateFolderAlert(row: indexPath.row)
            return
        }
    }

    /// フォルダ名の更新用ダイアログを表示する
    ///
    /// - Parameter row: TableViewの行番号
    private func showUpdateFolderAlert(row: Int) {

        let folder = dataSource.folder(index: row)

        alert = FolderAlertHelper()
            .createFolder(type: .update(index: row),
                          title: "フォルダの名前を変更",
                          message: "このフォルダの新しい名前を入力してください。",
                          folderName: folder.title,
                          delegate: self)

        present(alert, animated: true, completion: { [weak self] in
            self?.alert = nil
        })
    }
}

//MARK : - FolderProviderDelegate
extension FolderListViewController: FolderListProviderDelegate {

    func deleteFolder(index: Int) {
        FolderDao.delete(folderID: index)
        tableView.reloadData()
    }
}
