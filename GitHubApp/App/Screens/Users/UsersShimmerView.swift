//
//  UsersShimmerView.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class UsersShimmerView: UIView {
    
    // MARK: Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var shimmerViews: [UIView] = []
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 0)
        ])
        
        for _ in 0...5 {
            
            let containerView = UIView()
            
            let containerStackView = UIStackView()
            containerStackView.axis = .horizontal
            containerStackView.spacing = 8
            containerStackView.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(containerStackView)
            
            NSLayoutConstraint.activate([
                containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            ])
            
            let userImage = UIImageView()
            userImage.backgroundColor = .gray
            userImage.translatesAutoresizingMaskIntoConstraints = false
            
            containerStackView.addArrangedSubview(userImage)
            
            NSLayoutConstraint.activate([
                userImage.widthAnchor.constraint(equalToConstant: 60),
                userImage.heightAnchor.constraint(equalToConstant: 60)
            ])
            
            userImage.setRadius(radius: 30)
            
            let detailStackView = UIStackView()
            detailStackView.axis = .vertical
            detailStackView.spacing = 8
            
            let usernameView = UIView()
            usernameView.translatesAutoresizingMaskIntoConstraints = false
            detailStackView.addArrangedSubview(usernameView)
            
            NSLayoutConstraint.activate([
                usernameView.heightAnchor.constraint(equalToConstant: 30),
                usernameView.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
                usernameView.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor)
            ])
            
            let urlView = UIView()
            urlView.translatesAutoresizingMaskIntoConstraints = false
            detailStackView.addArrangedSubview(urlView)
            
            NSLayoutConstraint.activate([
                urlView.heightAnchor.constraint(equalToConstant: 30),
                urlView.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
                urlView.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor)
            ])
            
            containerStackView.addArrangedSubview(detailStackView)
            
            stackView.addArrangedSubview(containerView)
            shimmerViews.append(contentsOf: [userImage, usernameView, urlView])
            
        }
        
    }
    
    func startShimmer() {
        
        shimmerViews.forEach { (view) in
            view.shimmer()
        }
        
    }
    
}
