//
//  Dequeueable.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

public protocol Reusable {
    static var identifier: String { get }
}

public extension Reusable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    
    func dequeueCell<T: UITableViewCell>(ofType: T.Type,
                                         for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue Cell of type \(T.self)")
        }
        return cell
    }
}
