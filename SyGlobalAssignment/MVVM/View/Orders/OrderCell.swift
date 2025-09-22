//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 22/09/25.
//

import Foundation
import SwiftUI


struct OrderCell: View {
    let order: OrderModel
    var onEdit: (() -> ())? = nil
    var onDelete: (() -> ())? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Order #: \(order.orderNumber)")
                        .font(.headline)
                    
                    Text("Date: \(formattedDate(order.dueDate))")
                        .font(.subheadline)
                    
                    Text("Product: \(order.productName)")
                    Text("Address: \(order.address)")
                    Text("Phone: \(order.phone)")
                    
                    Text(String(format: "Amount: $%.2f", order.amount))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                
                Image("iPhone")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                
            }
            HStack {
                Spacer()
                
                Button {
                    onEdit?()
                }
                label: {
                    HStack {
                        Text("Edit")
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.blue)
                
                Divider()
                    .frame(width: 1, height: 12)
                    .background(Color.gray)
                
                Button {
                    onDelete?()
                }
                label:{
                    HStack {
                        Text("Delete")
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.red)
            }
            .padding(.top, 4)
            
        }
        .padding(.vertical, 8)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}



