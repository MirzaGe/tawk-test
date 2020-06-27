//
//  BaseViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    typealias AlertCallBack = ((_ userDidTapOk: Bool) -> Void)
    
    func alert(
        title: String,
        message: String? = nil,
        okayButtonTitle: String,
        cancelButtonTitle: String? = nil,
        withBlock completion: AlertCallBack?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in
            completion?(true)
        }
        alertController.addAction(okAction)
        
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default) { _ in
                completion?(false)
            }
            alertController.addAction(cancelAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
}
