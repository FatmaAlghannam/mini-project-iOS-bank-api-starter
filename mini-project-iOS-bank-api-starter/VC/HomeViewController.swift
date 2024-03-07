//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
//    
//    let signINButton =  UIButton(type: .system)
//    let signUPButton =  UIButton(type: .system)
//    let imageView = UIImageView()
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        title = "Banky"
//        
//        setUpUI()
//        subView()
//        autoLayout()
//        
//        signUPButton.addTarget(self, action: #selector(ButtonToSignUP), for: .touchUpInside)
//        signINButton.addTarget(self, action: #selector(ButtonToSignIN), for: .touchUpInside)
//    }
//    
//    
//    
//    func subView(){
//        view.backgroundColor = .white
//        view.addSubview(signINButton)
//        view.addSubview(signUPButton)
//        view.addSubview(imageView)
//
//    }
//    
//    func setUpUI(){
//        signINButton.setTitle("Sign in", for: .normal)
//        signINButton.backgroundColor = .systemGray
//        signINButton.setTitleColor(.white, for: .normal)
//        signINButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        signINButton.layer.cornerRadius = 10
//        signINButton.layer.borderWidth = 1
//        signINButton.layer.borderColor = UIColor.black.cgColor
//        
//        signUPButton.setTitle("Sign up", for: .normal)
//        signUPButton.backgroundColor = .systemGray
//        signUPButton.setTitleColor(.white, for: .normal)
//        signUPButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        signUPButton.layer.cornerRadius = 10
//        signUPButton.layer.borderWidth = 1
//        signUPButton.layer.borderColor = UIColor.black.cgColor
//        
//        imageView.image = UIImage(named: "banklogo")
//
//
//    }
//    
//    func autoLayout(){
//        imageView.snp.makeConstraints { make in
//                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//                make.leading.trailing.equalToSuperview().inset(16)
//                make.height.equalTo(view.snp.height).multipliedBy(0.3)
//            }
//
//        signINButton.snp.makeConstraints { make in
//                make.top.equalTo(imageView.snp.bottom).offset(20)
//                make.centerX.equalToSuperview()
//                make.width.equalTo(180)
//                make.height.equalTo(50)
//            }
//
//        signUPButton.snp.makeConstraints { make in
//                make.top.equalTo(signINButton.snp.bottom).offset(20)
//                make.centerX.equalToSuperview()
//                make.width.equalTo(180)
//                make.height.equalTo(50)
//            }
//    }
//    
//    func setupNavigationBar(){
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    }
//    
//    @objc func ButtonToSignUP(){
//        let signupVC = SignUpViewController()
//        self.navigationController?.pushViewController(signupVC, animated: true)
//    }
//    @objc func ButtonToSignIN(){
//        let signinVC = SignInViewController()
//        self.navigationController?.pushViewController(signinVC, animated: true)
//    }
//
//    
//
//
//}
//
    let containerView = UIView()
       let signINButton = UIButton(type: .system)
       let signUPButton = UIButton(type: .system)
       let imageView = UIImageView()
    let image = UIImageView()

       
       override func viewDidLoad() {
           super.viewDidLoad()
           title = "Banky"
           view.backgroundColor = .white
           
           setUpUI()
           subView()
           autoLayout()
           
           signUPButton.addTarget(self, action: #selector(ButtonToSignUP), for: .touchUpInside)
           signINButton.addTarget(self, action: #selector(ButtonToSignIN), for: .touchUpInside)
       }
       
       func subView() {
           view.addSubview(imageView)
           view.addSubview(containerView)
           view.addSubview(image)
           containerView.addSubview(signINButton)
           containerView.addSubview(signUPButton)
       }
       
       func setUpUI() {
           imageView.image = UIImage(named: "Banky")
           image.image = UIImage(named: "draya")

           
           signINButton.setTitle("Sign in", for: .normal)
           signINButton.backgroundColor = .lightGray
           signINButton.setTitleColor(.black, for: .normal)
           signINButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
           signINButton.layer.cornerRadius = 10
           signINButton.layer.borderWidth = 1
           signINButton.layer.borderColor = UIColor.white.cgColor
           
           signUPButton.setTitle("Sign up", for: .normal)
           signUPButton.backgroundColor = .lightGray
           signUPButton.setTitleColor(.black, for: .normal)
           signUPButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
           signUPButton.layer.cornerRadius = 10
           signUPButton.layer.borderWidth = 1
           signUPButton.layer.borderColor = UIColor.white.cgColor
           
           containerView.backgroundColor = .clear
           containerView.layer.cornerRadius = 20
           containerView.clipsToBounds = true
           containerView.layer.borderWidth = 1
           containerView.layer.borderColor = UIColor.darkGray.cgColor
       }
       
       func autoLayout() {
           imageView.snp.makeConstraints { make in
               make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
               make.leading.trailing.equalToSuperview().inset(16)
               make.height.equalTo(view.snp.height).multipliedBy(0.3)
           }
           
           containerView.snp.makeConstraints { make in
               make.top.equalTo(imageView.snp.bottom).offset(40)
               make.leading.trailing.equalToSuperview().inset(20)
               make.height.equalTo(100)
           }
           
           signINButton.snp.makeConstraints { make in
               make.centerY.equalTo(containerView)
               make.leading.equalTo(containerView).offset(20)
               make.width.equalTo(containerView).multipliedBy(0.4)
               make.height.equalTo(50)
           }
           
           signUPButton.snp.makeConstraints { make in
               make.centerY.equalTo(containerView)
               make.trailing.equalTo(containerView).inset(20)
               make.width.equalTo(containerView).multipliedBy(0.4)
               make.height.equalTo(50)
           }
           image.snp.makeConstraints { make in
                 make.leading.trailing.equalToSuperview().inset(16)
                 make.bottom.equalTo(containerView.snp.top).offset(450)
                 make.height.equalTo(view.snp.height).multipliedBy(0.3)
             }
       }
       
       @objc func ButtonToSignUP() {
           let signupVC = SignUpViewController()
           self.navigationController?.pushViewController(signupVC, animated: true)
       }
       
       @objc func ButtonToSignIN() {
           let signinVC = SignInViewController()
           self.navigationController?.pushViewController(signinVC, animated: true)
       }
   }
