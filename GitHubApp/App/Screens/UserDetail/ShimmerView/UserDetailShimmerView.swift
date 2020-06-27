//
//  UserDetailShimmerView.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class UserDetailShimmerView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var shimmerViewCollection: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func nibSetup() {
        
        backgroundColor = .clear
        
        Bundle.main.loadNibNamed("UserDetailShimmerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func startShimmer() {
        for view in shimmerViewCollection {
            view.shimmer()
        }
    }
    
}
