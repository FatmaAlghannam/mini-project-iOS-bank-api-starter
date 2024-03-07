//
//  WithdrawViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Razan alshatti on 06/03/2024.
//

import UIKit
import Eureka
import Kingfisher
import SnapKit
import Alamofire

class WithdrawViewController: FormViewController {
    
    weak var delegate: RefreshDelegate?
    
    var token: String?
    
    let notificationLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .clear
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.layer.cornerRadius = 8
            label.numberOfLines = 0 // Allow multiple lines for the message
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        setupform()
    }
    
    func setupform(){
        
        form +++ Section("Withdraw")
        
        <<< DecimalRow(){ row in
            row.title = "Withdrawal Amount:"
            row.placeholder = "Enter Amount"
            row.tag = "Withdrawal Amount:"
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        form +++ Section("")
        
        <<< ButtonRow(){ row in
            row.title = "Withdraw"
            row.onCellSelection { cell, row in
                self.withdraw()
            }
        }
    }
    
    func withdraw(){
        
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        //getting data from the row
        let withdrawRow: DecimalRow? = form.rowBy(tag: "Withdrawal Amount:")
        
        //convert data to string ,INT ,etc
        let withdraw = withdrawRow?.value ?? 0.0
        var amountChange = AmountChange(amount: Double(withdraw) ?? 0.0)
        
        NetworkManager.shared.withdraw(token: token ?? "", amountChange: amountChange) { result in
            switch result {
            case .success():
                print("Successful Withdraw")
                DispatchQueue.main.async {
                    self.showNotification(message: "Withdraw successful!", color: .green)
                    
                    // Dismiss the DepositViewController after a slight delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            case .failure(let afError):
                print(afError)
                DispatchQueue.main.async {
                    self.showNotification(message: "Withdrawal failed. Please try again.", color: .red)
                }
            }
        }
       }
    func showNotification(message: String, color: UIColor) {
        notificationLabel.text = message
        notificationLabel.backgroundColor = color
        view.addSubview(notificationLabel)
        
        // Layout constraints for notificationLabel
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            notificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notificationLabel.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
        
        // Fade out notification label after 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 270) {
                self.notificationLabel.alpha = 0
            } completion: { _ in
                self.notificationLabel.removeFromSuperview()
            }
        }
    }

    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
        
    }

}
