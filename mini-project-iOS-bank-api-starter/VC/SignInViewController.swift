//
//  SignInViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by fatma adnan on 06/03/2024.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import Eureka

class SignInViewController: FormViewController {
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForm()
    }
    
    func setUpForm(){
        form +++ Section("Sign In ")
        <<< TextRow(){row in
            row.title = "Username"
            row.placeholder = "Enter Username"
            row.tag = "UserName"
            
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }}
            
            <<< PasswordRow{ row in
                row.title = "Password"
                row.placeholder = "Enter your password here"
                row.tag = "Password"
                
                //red color and error
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.cellUpdate { cell, row in
                    if !row.isValid{
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
//        <<< CheckRow(){ row in
//            
//        }
        
            form +++ Section("")
            
            <<< ButtonRow(){ row in
                row.title = "Sign In"
                row.onCellSelection { cell, row in
                    self.signIn()
                }
            }
        }
        
    
    
    @objc func signIn(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        //getting data from the row
        let usernameRow: TextRow? = form.rowBy(tag: "UserName")
        let passwordRow: PasswordRow? = form.rowBy(tag: "Password")
        
        
        //convert data to string ,INT ,etc
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        
        
        print(username)
        let user = User(username: username,email: "", password: password)
        
        
        
        NetworkManager.shared.signin(user: user) { result in
            switch result {
            case .success(let tokenResponse):
                
                print("Sign in successful. Token: \(tokenResponse.token)")
                DispatchQueue.main.async {
                   
                                    
                    let signVC = AccountViewController()
                    signVC.token = tokenResponse.token
                    self.navigationController?.pushViewController(signVC, animated: true)

                }
            case .failure(let error):
                
                print("Sign in failed with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
        }
    }

    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}


