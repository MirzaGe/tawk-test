//
//  AppColors.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

enum AppColors {
    
    case backgroundColor
    case textColor
    
    var value: UIColor {
        switch self {
        case .backgroundColor:
            return UIColor(named: "BackgroundColor")!
        case .textColor:
            return UIColor(named: "TextColor")!
        }
    }
    
}
