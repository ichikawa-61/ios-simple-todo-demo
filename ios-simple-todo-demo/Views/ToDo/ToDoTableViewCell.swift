//
//  ToDoTableViewCell.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    var todo: ToDo? {

        didSet {

            titleLabel.text = todo?.title

            if let date = todo?.date {
                dateLabel.text = date.toStr(dateFormat: "yyyy/MM/dd")
            }
        }
    }
}

