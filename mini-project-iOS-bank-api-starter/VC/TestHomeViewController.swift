//
//  HomeViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Razan alshatti on 06/03/2024.
//

import UIKit
import Alamofire
import Kingfisher
import Eureka
import SnapKit

class TestHomeViewController: UIViewController {
    
    var usertoken: String? = ""
    var userAmount: AmountChange?
    
    // Container for Balance
    let balanceContainer = UIView()
    let balanceLabel = UILabel()

    // Container for Deposit
    let depositContainer = UIView()
    let amountTextField = UITextField()
    let depositButton = UIButton()

    // Container for Withdraw
    let withdrawContainer = UIView()
    let withdrawalTextField = UITextField()
    let withdrawButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
             setupBalanceUI()
             setupDepositUI()
             

    }
    // Function to setup UI for Balance Container
       func setupBalanceUI() {
           balanceContainer.frame = CGRect(x: 20, y: 50, width: 300, height: 100)
           balanceContainer.backgroundColor = UIColor.systemBlue
           balanceContainer.layer.cornerRadius = 10
           view.addSubview(balanceContainer)

           balanceLabel.frame = CGRect(x: 10, y: 10, width: 280, height: 80)
           balanceLabel.textColor = UIColor.white
           balanceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           balanceLabel.textAlignment = .center
           balanceContainer.addSubview(balanceLabel)
       }

       // Function to setup UI for Deposit Container
       func setupDepositUI() {
           depositContainer.frame = CGRect(x: 20, y: 180, width: 300, height: 150)
           depositContainer.backgroundColor = UIColor.systemGreen
           depositContainer.layer.cornerRadius = 10
           view.addSubview(depositContainer)

           amountTextField.frame = CGRect(x: 20, y: 20, width: 260, height: 40)
           amountTextField.borderStyle = .roundedRect
           amountTextField.placeholder = "Enter deposit amount"
           depositContainer.addSubview(amountTextField)

           depositButton.frame = CGRect(x: 20, y: 80, width: 260, height: 40)
           depositButton.setTitle("Deposit", for: .normal)
           depositButton.setTitleColor(UIColor.white, for: .normal)
           depositButton.backgroundColor = UIColor.systemBlue
           depositButton.layer.cornerRadius = 8
           depositButton.addTarget(self, action: #selector(depositButtonTapped), for: .touchUpInside)
           depositContainer.addSubview(depositButton)
       }


    @objc func depositButtonTapped() {
//        NetworkManager.shared.addPet(pet: pet) { success in
//            DispatchQueue.main.async {
//                if success {
//                    self.dismiss(animated: true, completion: nil)
//                } else {
//                    // Handle submission error
//                    print("error")
//                }
//            }
//        }
        
//        NetworkManager.shared.deposit(token: userToken?.token ?? "", amountChange: userAmount ?? nil) { success in
//            DispatchQueue.main.async {
//                if success {
//                    self.dismiss(animated: true, completion: nil)
//                } else {
//                    print("error")
//                }
//            }
//        }


    }


    
}
