//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import SwiftUI


struct RegisterView: View {
    
    @State private var userName: String = ""
    @State private var userPassword: String = ""
    @State private var userConfirmPassword: String = ""
    @State private var isRegTapped: Bool = false
    
    @EnvironmentObject var session: SessionManager

    var body: some View {
        ZStack {
            gradientColor(color1: .purple, color2: .blue)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer().frame(height: 80)
                
                Text("Create your account")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                
                contentView
                
                Spacer()
            }
            
        }
      
        .navigationDestination(isPresented: $isRegTapped) {
            TabContainerView()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    var contentView: some View {
        
        VStack(spacing: 20) {
            
            TextField("Enter Name", text: $userName)
                .roundedTextFieldStyle()
            
            SecureField("Enter Password", text: $userPassword)
                .roundedTextFieldStyle()
            
            SecureField("Enter Confirm Password", text: $userConfirmPassword)
                .roundedTextFieldStyle()
            
            Button(action: {
                registerAction()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        gradientColor(
                            color1: .pink,
                            color2: .blue,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .cornerRadius(10)
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
            .buttonStyle(.plain)
            
            HStack {
                Text("Already have an account? change in main unnecessary")
                    .foregroundColor(.gray)
                Text("rewrite the line in main with change")

                NavigationLink("Login", destination: LoginView())
                    .foregroundColor(.purple)
                    .bold()
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding(.horizontal)
        
    }
    
    private func registerAction() {
        let users = CoreDataManager.shared.fetchAllUsers()
        
        if !users.compactMap({ $0.name }).contains(self.userName) {
            CoreDataManager.shared.saveContext(
                userModel: UserModel(
                    userName: self.userName,
                    userPassword: self.userPassword
                )
            )
            withAnimation(.easeInOut(duration: 0.5)) {
                session.isLoggedIn = true
                isRegTapped = true
            }
        } else {
            print("Name already exists")
        }
    }
}


#Preview {
    RegisterView()
}
