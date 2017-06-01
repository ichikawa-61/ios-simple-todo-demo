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
            self.titleLabel.text = folder?.title

            if let count = folder?.count {
                self.countLabel.text = "\(count)"
            } else {
                self.countLabel.text = "0"
            }
        }
    }
}
