//
//  BaseViewController.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/27/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    lazy var snackbarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var snackbarMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupReachability()
    }
    
    private func setupViews() {
        
        self.view.addSubview(snackbarView)
        
        NSLayoutConstraint.activate([
            snackbarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            snackbarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            snackbarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            snackbarView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        snackbarView.addSubview(snackbarMessageLabel)
        
        NSLayoutConstraint.activate([
            snackbarMessageLabel.centerYAnchor.constraint(equalTo: snackbarView.centerYAnchor),
            snackbarMessageLabel.centerXAnchor.constraint(equalTo: snackbarView.centerXAnchor)
        ])
    
        snackbarView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.bringSubviewToFront(snackbarView)
    }
    
    // for reachability
    private var retryCount = 0
    let reachability = try? Reachability()
    private var fromOfflineMode = false
    
    private func setupReachability() {
        
        self.reachability?.whenReachable = { [unowned self] reachability in
            
            if self.fromOfflineMode {
                NotificationCenter.default.post(name: AppNotificationName.onlineMode, object: nil)
                self.showBackOnlineSnackBar()
            }
            
        }
        
        self.reachability?.whenUnreachable = { [unowned self] _ in
          
            self.fromOfflineMode = true
            NotificationCenter.default.post(name: AppNotificationName.offlineMode, object: nil)
            self.showOfflineModeSnackBar()
            
        }
        
        do {
            try self.reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        guard let connection = self.reachability?.connection else { return }
        
        self.fromOfflineMode = connection == .unavailable
        NotificationCenter.default.post(name: AppNotificationName.offlineMode, object: nil)
        
    }
    
    private func retryWhenConnectionIsAvailable() {
        guard let connection = self.reachability?.connection else { return }
        
        if connection == .unavailable {
            executeExponentionBackoff(on: DispatchQueue.main, retry: self.retryCount) {
                [unowned self] in
                
                self.retryCount += 1
                self.retryWhenConnectionIsAvailable()
            }
        }
    }
    
    func executeExponentionBackoff(on queue: DispatchQueue, retry: Int = 0, closure: @escaping () -> Void) {
        let delay = getDelay(for: retry)
        queue.asyncAfter(
            deadline: DispatchTime.now() + .milliseconds(delay),
            execute: closure)
    }
    
    func getDelay(for n: Int) -> Int {
        let maxDelay = 600000 // 10 mins
        let delay = Int(pow(2.0, Double(n))) * 1000
        let jitter = Int.random(in: 0...1000)
        
        return min(delay + jitter, maxDelay)
    }
    
    private func showOfflineModeSnackBar() {
        
        snackbarView.backgroundColor = .red
        snackbarMessageLabel.text = AppStrings.offlineModeMessage.rawValue.getLocalize()
        
        snackbarView.isHidden = false
        
    }
    
    private func showBackOnlineSnackBar() {
        
        snackbarView.backgroundColor = .green
        snackbarMessageLabel.text = AppStrings.onlineModeMessage.rawValue.getLocalize()
        
        snackbarView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            [unowned self] in
            
            self.snackbarView.isHidden = true
        }
        
    }
    
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
