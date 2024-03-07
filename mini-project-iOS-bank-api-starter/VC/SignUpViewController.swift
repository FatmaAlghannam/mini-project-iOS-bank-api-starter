//
//  SignUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by fatma adnan on 06/03/2024.
//

import UIKit
import Eureka
import SnapKit
import Kingfisher
import Alamofire

class SignUpViewController: FormViewController{
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    
    func setUp(){
        form +++ Section("Sign Up")
        <<< TextRow{ row in
            row.title = "Username"
            row.placeholder = "Enter your username here"
            row.tag = "Username"
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
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
        <<< EmailRow{ row in
            row.title = "Email"
            row.placeholder = "Enter your email"
            row.tag = "Email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        +++ Section()
        <<< ButtonRow{ row in
            row.title = "Sign Up"
            row.onCellSelection { cell, row in
                self.signUp()
            }
        }
    }
    
    @objc func signUp(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        //getting data from the row
        let usernameRow: TextRow? = form.rowBy(tag: "Username")
        let passwordRow: PasswordRow? = form.rowBy(tag: "Password")
        let emailRow: EmailRow? = form.rowBy(tag: "Email")
        
        
        //convert data to string ,INT ,etc
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let email = emailRow?.value ?? ""
        
        
        
        let user = User(username: username, email: email, password: password)
        print(user)
        
        
        NetworkManager.shared.signup(user: user) { success in
            DispatchQueue.main.async{
                switch success {
                case .success(let tokenResponse):
                    let signupVC = AccountViewController()
                    signupVC.token = tokenResponse.token
                    self.navigationController?.pushViewController(signupVC, animated: true)
                    print("Successful Token\(tokenResponse.token)")
                case .failure(let afError):
                    print(afError)
                }
            }
            
        }
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}
