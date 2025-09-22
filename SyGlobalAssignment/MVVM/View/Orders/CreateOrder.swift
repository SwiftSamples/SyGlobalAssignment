//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 22/09/25.
//

import SwiftUI
struct CreateOrder: View {
    @State private var name = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var amount = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 10) {
            
            CustomHeaderView(title: "Create Order") {
                dismiss()
            }
            Divider()
            
            contentFieldsView()
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    @ViewBuilder func contentFieldsView() -> some View {
        ScrollView {
        VStack {
            Section(header: Text("Order Information")) {
                TextField("Enter product name", text: $name)
                    .roundedTextFieldStyle()
                
                TextField("Enter your address", text: $address)
                    .roundedTextFieldStyle()
                
                TextField("Enter your phone number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .roundedTextFieldStyle()
                
                TextField("Enter amount", text: $amount)
                    .keyboardType(.numberPad)
                    .roundedTextFieldStyle()
            }
            
            Button(action: {
                placeOredr()
            }) {
                Text("Place Order")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        gradientColor(color1: .pink, color2: .blue, startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(10)
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
            .disabled(name.isEmpty || address.isEmpty || phoneNumber.isEmpty)
            
            Spacer()
        }
        .padding(.top, 20)
    }
    }
    
    private func placeOredr() {
        if let amountValue = Double(amount) {
            let orderModel = CreateOrderModel(
                name: name,
                address: address,
                phoneNum: phoneNumber,
                amount: amountValue
            )
            let success = CoreDataManager.shared.saveOrder(orderModel: orderModel)
            if success {
                dismiss()
            }
        } else {
            print("Invalid amount entered")
        }
    }
}


#Preview {
    CreateOrder()
}

