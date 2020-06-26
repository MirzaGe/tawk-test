//
//  InitFromNib.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

protocol InitFromNib where Self: UIViewController {
    
    static func initFromNib() -> Self
    
}

extension InitFromNib {
    
    static func initFromNib() -> Self {
        let name = String(describing: self)
        return Self.init(nibName: name, bundle: nil)
    }
    
}
