//
//  UserModel.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import Foundation

struct UserModel {
    var userName: String
    var userPassword: String
}

// MARK: - Order Model

struct OrderModel: Identifiable {
    let id = UUID()
    let orderNumber: String
    let dueDate: Date
    let productName: String
    let address: String
    let phone: String
    let amount: Double
}

struct CreateOrderModel: Codable, Identifiable {
    var id = UUID()
    let name: String
    let address: String
    let phoneNum: String
    let amount: Double

}
