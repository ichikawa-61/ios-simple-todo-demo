//
//  FolderListProvider.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol FolderListProviderDelegate: class {
    func deleteFolder(folderID: Int)
}

final class FolderListProvider: NSObject {

    //MARK : - Properties
    weak var delegate: FolderListProviderDelegate?
    fileprivate var folders = [Folder]()

    //MARK : - Public Methods
    /// フォルダ一覧を設定する
    ///
    /// - Parameter folders: フォルダ一覧
    func set(folders: [Folder]) {
        self.folders = folders
    }

    /// 該当のフォルダを取得する
    ///
    /// - Parameter index: TableViewのインデックス
    /// - Returns: フォルダ
    func folder(index: Int) -> Folder {
        guard index < folders.count else {
            fatalError("foldersの要素数を超えました。")
        }
        return folders[index]
    }
}

//MARK : - UITableViewDataSource
extension FolderListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView
            .dequeueReusableCell(withIdentifier: FolderTableViewCell.identifier,
                                 for: indexPath) as? FolderTableViewCell
        cell?.folder = folder(index: indexPath.row)
        return cell!
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            let _folder = folder(index: indexPath.row)
            folders.remove(at: indexPath.row)
            delegate?.deleteFolder(folderID: _folder.folderID)
        }
    }
}
