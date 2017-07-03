//
//  FolderTableViewCell.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class FolderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    /// フォルダ
    var folder: Folder? {

        didSet {
            titleLabel.text = folder?.title
            countLabel.text = folder?.taskCount
        }
    }
}
