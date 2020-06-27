//
//  UserDetailViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Combine

class UserDetailViewController: UIViewController, InitFromNib {

    // MARK: - Outlets
    @IBOutlet weak var blurredImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private var shimmerView: UserDetailShimmerView?
    private var imageRequest: AnyCancellable?
    
    
    // MARK: - Properties
    var viewModel: UserDetailViewModelInputs?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.shimmerView?.startShimmer()
        self.viewModel?.getUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.imageRequest?.cancel()
    }
    
    private func setupViews() {
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.shimmerView = UserDetailShimmerView()
        shimmerView?.translatesAutoresizingMaskIntoConstraints = false
        shimmerView?.backgroundColor = AppColors.backgroundColor.value
        
        self.view.addSubview(shimmerView!)
        
        NSLayoutConstraint.activate([
            self.shimmerView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.shimmerView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.shimmerView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.shimmerView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurredImage.addSubview(blurredEffectView)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurredEffectView.topAnchor.constraint(equalTo: self.blurredImage.topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: self.blurredImage.bottomAnchor),
            blurredEffectView.leadingAnchor.constraint(equalTo: self.blurredImage.leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: self.blurredImage.trailingAnchor)
        ])
        
    }
    
    private func bindViewModel() {
        
        viewModel?.outputs()
            .user
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (user) in
                self.removeShimmerView()
                self.setupUserData(data: user)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    private func removeShimmerView() {
        shimmerView?.removeFromSuperview()
        shimmerView = nil
    }
    
    private func setupUserData(data: UserFormatter) {
        
        self.title = data.getName()
        
        self.followersLabel.text = data.getFormattedFollowers()
        self.followingLabel.text = data.getFormattedFollowing()
        
        self.nameLabel.text = data.getFormattedName()
        self.companyLabel.text = data.getFormattedCompany()
        self.blogLabel.text = data.getFormattedBlog()
        
        if let url = URL(string: data.getAvatarUrl()) {
            
            imageRequest = ImageLoader.shared.loadImage(from: url).sink { [unowned self] (image) in
                
                self.blurredImage.image = image
                self.userImage.image = image
            }
            
        }
        
    }

}
