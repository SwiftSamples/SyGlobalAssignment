//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 22/09/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var orders: [OrderModel] = []
    @State private var navigateToCreateOrder = false
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing: 0) {
                
                logoutButton
                
                addOrderButton
                Divider()
                    .padding(.horizontal)
                
                listView
                
                Spacer()
            }
            .navigationDestination(isPresented: $navigateToCreateOrder) {
                CreateOrder()
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                let fetchedOrders = CoreDataManager.shared.fetchOrders()
                self.orders = fetchedOrders
            }
        }
    }
    
    var logoutButton: some View {
        Button(action: {
            withAnimation {
                session.isLoggedIn = false
            }
        }) {
            Text("Logout")
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.red)
                .cornerRadius(8)
        }
    }
    var addOrderButton: some View {
        HStack {
            Text("📦 Products")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            Button(action: {
                navigateToCreateOrder = true
            }) {
                Label("Add Order", systemImage: "plus.circle.fill")
                    .font(.subheadline.bold())
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                        gradientColor(color1: .pink, color2: .blue, startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(10)
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }
    
    var listView: some View {
        Group {
            if orders.isEmpty {
                VStack(alignment: .center, spacing: 12) {
                    Image(systemName: "shippingbox.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.blue.opacity(0.7))
                    
                    Text("No Orders Yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text("Tap 'Add Order' to create your first order.")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
            } else {
                List(orders) { order in
                    OrderCell(
                        order: order,
                        onEdit: { print("edit tapped") },
                        onDelete: { deleteOrder(order) }
                    )
                }
                .listStyle(.plain)
            }
        }
    }
    
    func deleteOrder(_ order: OrderModel) {
        withAnimation {
            let deleted = CoreDataManager.shared.deleteOrder(orderModel: order)
            if deleted, let index = orders.firstIndex(where: { $0.id == order.id }) {
                orders.remove(at: index)
            }
        }
    }
}


