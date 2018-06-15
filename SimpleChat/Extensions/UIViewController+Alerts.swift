//
//  UIViewController+Alerts.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 15.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(withTitle title: String?, message: String, confirmButtonTitle: String, cancelButtonTitle: String, confirmAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .default, handler: cancelAction))
            alert.addAction(UIAlertAction(title: confirmButtonTitle, style: .default, handler: confirmAction))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showOKAlert(withTitle title: String?, message: String, okButtonTitle: String, okAction: ((UIAlertAction) -> Void)? = nil) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: okButtonTitle, style: UIAlertActionStyle.default, handler: okAction))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
