//
//  UserTableViewCell.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - UI Properties
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "ic-github")
        return image
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Test"
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.text = "Test"
        return label
    }()
    
    private lazy var notesImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "ic-github")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        containerStackView.addArrangedSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        detailsStackView.addArrangedSubview(usernameLabel)
        detailsStackView.addArrangedSubview(urlLabel)
        containerStackView.addArrangedSubview(detailsStackView)
        
        contentView.addSubview(notesImage)
        
        NSLayoutConstraint.activate([
            notesImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            notesImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            notesImage.widthAnchor.constraint(equalToConstant: 25),
            notesImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }

}
