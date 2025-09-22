//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import Foundation
import CoreData


class CoreDataManager {
    
    
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "SystemTest")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    // MARK: - Save Context
    func saveContext(userModel: UserModel) {
        let newUser = User(context: context)
        newUser.name = userModel.userName
        newUser.password = userModel.userPassword
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUser(userModel: UserModel) -> Bool {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "name == %@ AND password == %@",
            userModel.userName,
            userModel.userPassword
        )
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                
                return true
            } else {
                return false
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllUsers() -> [User] {
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                print("Name: \(user.name ?? ""), Password: \(user.password ?? "")")
            }
            return users
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveOrder(orderModel: CreateOrderModel) -> Bool {
        let newOrder = Order(context: context)
        newOrder.name = orderModel.name
        newOrder.address = orderModel.address
        newOrder.phoneNum = orderModel.phoneNum
        newOrder.amount = orderModel.amount
        do {
            try context.save()
            return true
        } catch {
            print("Failed to save order: \(error.localizedDescription)")
            return false
        }
    }

    func deleteOrder(orderModel: OrderModel) -> Bool {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND phoneNum == %@",
                                             orderModel.productName,
                                             orderModel.phone)
        do {
            let results = try context.fetch(fetchRequest)
            if let orderToDelete = results.first {
                context.delete(orderToDelete)
                try context.save()
                return true
            }
        } catch {
            print("Failed to delete order: \(error.localizedDescription)")
        }
        return false
    }


    
    func fetchOrders() -> [OrderModel] {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do {
            let orders = try context.fetch(fetchRequest)

            return orders.enumerated().map { index, order in
                OrderModel(
                    orderNumber: String(index + 1),
                    dueDate: Date(),
                    productName: order.name ?? "",
                    address: order.address ?? "",
                    phone: order.phoneNum ?? "",
                    amount: order.amount
                )
            }
        } catch {
            print("Failed to fetch orders: \(error)")
            return []
        }
    }
    
}
