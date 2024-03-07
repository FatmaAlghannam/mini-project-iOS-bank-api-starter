//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Razan alshatti on 06/03/2024.
//


import UIKit
import Alamofire

class ProfileViewController: UITableViewController {
    
    var token: String?
    
    var transaction: [Transaction] = []
    
    let amountLabel = UILabel()
    let typeLabel = UILabel()


        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            fetchTransaction()
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transaction.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 60
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")

        let transaction = transaction[indexPath.row]
        
        cell.textLabel?.text = "\(transaction.type)"
        cell.detailTextLabel?.text = "Amount: \(transaction.amount)"
        cell.textLabel?.numberOfLines = 2
        
        if transaction.type == "deposit" {
            cell.detailTextLabel?.text = "+ \(transaction.amount)"
        } else {
            cell.detailTextLabel?.text = "- \(transaction.amount)"
        }
        
        if transaction.type == "deposit" {
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        } else {
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)

        }

        return cell
    }
    
    func subView(){
        
        view.addSubview(amountLabel)
        view.addSubview(typeLabel)
    }
    
    func setupUI(){
        amountLabel.textColor = .black
        amountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        typeLabel.textColor = .black
        typeLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func fetchTransaction() {
        guard let token = token else {
                    print("NO TOKEN")
                    return
                }

        NetworkManager.shared.fetchTransaction(token: token) { result in
            switch result {
            case .success(let transaction):
                self.transaction = transaction
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print("NO TRANSACTION FOUND")
            }
        }
    }
}
