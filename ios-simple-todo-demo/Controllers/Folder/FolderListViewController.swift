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

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    //MARK : - Action
    @IBAction func didTapEditFolder(_ sender: UIBarButtonItem) {
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        setupEditButton(isEditing: editing)
    }

    /// ナビゲーションバーを設定する
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.hideBackButtonTitle()
    }

    /// 編集ボタンを設定する
    ///
    /// - Parameter isEditing: 編集モードか？
    private func setupEditButton(isEditing: Bool) {
        editButton.title = isEditing ?
            "すべて削除" : "新規作成"
    }
}
