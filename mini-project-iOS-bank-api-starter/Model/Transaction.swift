//
//  Transaction.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Razan alshatti on 07/03/2024.
//

import Foundation



struct Transaction: Codable {
    let senderId: Int
    let receiverId: Int
    let amount: Double
    let type: String
}
