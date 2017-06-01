//
//  Alertable.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol FormAlertable {

    func showCreate(topOf: UIViewController)
    func showUpdate(index: Int, title: String, topOf: UIViewController)
    func showDeleteAll(topOf: UIViewController)
}

extension FormAlertable where Self: NSObject {

    func showDeleteAll(topOf: UIViewController) {

        let alert = FormAlertHelper()
            .deleateFolder(delegate: topOf as! FormAlertHelperDelegate)
        topOf.present(alert, animated: true, completion: nil)
    }
}
