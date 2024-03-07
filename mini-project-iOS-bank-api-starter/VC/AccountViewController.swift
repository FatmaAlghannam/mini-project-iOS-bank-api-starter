//
//  AccountViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by fatma adnan on 06/03/2024.
//

import UIKit

class AccountViewController: UIViewController {
    
    var userDetail: UserDetail?
    
    var token: String?
    let depositButton =  UIButton(type: .system)
    let withdrawButton =  UIButton(type: .system)
    let transferButton =  UIButton(type: .system)

    let imageView = UIImageView()
    let containerView = UIView()
    
    let image = UIImageView()
    
    let usernameLabel = UILabel()
    let balanceLabel = UILabel()
    let profileContainer = UIView()
    
    let imageProfile = UIImageView()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setUpUI()
        subView()
        autoLayout()
        setupNavigationBar()
        fetchUserDetails()
        refreshData()
        depositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)
        
    }
    
    func setUpUI(){

        depositButton.setTitle("DEPOSIT", for: .normal)
        depositButton.backgroundColor = .lightGray
        depositButton.setTitleColor(.black, for: .normal)
        depositButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        depositButton.layer.cornerRadius = 10
        depositButton.layer.borderWidth = 1
        depositButton.layer.borderColor = UIColor.white.cgColor
        
        withdrawButton.setTitle("WITHDRAW", for: .normal)
        withdrawButton.backgroundColor = .lightGray
        withdrawButton.setTitleColor(.black, for: .normal)
        withdrawButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        withdrawButton.layer.cornerRadius = 10
        withdrawButton.layer.borderWidth = 1
        withdrawButton.layer.borderColor = UIColor.white.cgColor
        
        transferButton.setTitle("TRANSFER", for: .normal)
        transferButton.backgroundColor = .lightGray
        transferButton.setTitleColor(.black, for: .normal)
        transferButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        transferButton.layer.cornerRadius = 10
        transferButton.layer.borderWidth = 1
        transferButton.layer.borderColor = UIColor.white.cgColor
        
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        
        profileContainer.backgroundColor = .clear
        profileContainer.layer.cornerRadius = 20
        profileContainer.clipsToBounds = true
        profileContainer.layer.borderWidth = 1
        profileContainer.layer.borderColor = UIColor.darkGray.cgColor
        
        usernameLabel.textColor = .black
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        balanceLabel.textColor = .black
        balanceLabel.font = UIFont.systemFont(ofSize: 16)

        imageView.image = UIImage(named: "mywallet")
        image.image = UIImage(named: "draya")
        imageProfile.image = UIImage(systemName: "person.crop.square")
        imageProfile.tintColor = .black
        

        
        
    }
    
    func subView(){
        view.backgroundColor = .white
        view.addSubview(depositButton)
        view.addSubview(withdrawButton)
        view.addSubview(imageView)
        view.addSubview(containerView)
        view.addSubview(image)
        view.addSubview(usernameLabel)
        view.addSubview(balanceLabel)
        view.addSubview(profileContainer)
        view.addSubview(imageProfile)
        view.addSubview(transferButton)
        containerView.addSubview(depositButton)
        containerView.addSubview(withdrawButton)
        profileContainer.addSubview(usernameLabel)
        profileContainer.addSubview(balanceLabel)
        
    }
    

    func autoLayout(){
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(120)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        depositButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.leading.equalTo(containerView).offset(20)
            make.width.equalTo(containerView).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.trailing.equalTo(containerView).inset(20)
            make.width.equalTo(containerView).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        profileContainer.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileContainer.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            
            
        }
        
        image.snp.makeConstraints { make in
              make.leading.trailing.equalToSuperview().inset(16)
              make.bottom.equalTo(containerView.snp.top).offset(450) 
              make.height.equalTo(view.snp.height).multipliedBy(0.3)
          }
        imageProfile.snp.makeConstraints { make in
            make.leading.equalTo(profileContainer.snp.trailing).offset(-100)
            make.centerY.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(90)
        }
        
        transferButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
    }
    
    func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "creditcard.fill"),
            style: .plain,
            target: self,
            action: #selector(infoTapped)
        )
    }
    
    func fetchUserDetails() {
        guard let token = token else {
            print("NO TOKEN")
            return
        }
        
        NetworkManager.shared.fetchUserDetails(token: token) { result in
            DispatchQueue.main.async{
            switch result {
            case .success(let details):
                self.title = "\(details.username)"
                self.usernameLabel.text = details.username
                self.balanceLabel.text = "\(details.balance)KD"
                self.refreshData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
        @objc func depositTapped(){
            
            let depositVC = DepositViewController()
            depositVC.modalPresentationStyle = .popover
            self.navigationController?.pushViewController(depositVC, animated: true)
            
            depositVC.token = token
            depositVC.delegate = self
        }
        @objc func withdrawTapped(){
            
            let withdrawVC = WithdrawViewController()
            withdrawVC.modalPresentationStyle = .popover
            self.navigationController?.pushViewController(withdrawVC, animated: true)
            
            withdrawVC.token = token
            withdrawVC.delegate = self
        }
        @objc func infoTapped() {
            let instructionVC = ProfileViewController()
            instructionVC.token = token
            navigationController?.pushViewController(instructionVC, animated: true)
        
        }
    @objc func TransferTapped(){
        let transferVC = TransferViewController()
        transferVC.modalPresentationStyle = .popover
        self.present(transferVC, animated: true)
    }
        
        
    }

extension AccountViewController: RefreshDelegate{
    func refreshData() {
        fetchUserDetails()
    }
}
