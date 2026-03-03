//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    
    @State private var userName: String = ""
    @State private var uaerPassword: String = ""
    @State private var isLoginTapped: Bool = false
    @State private var isRegTapped: Bool = false
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                gradientColor(color1: .purple, color2: .blue)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    Spacer().frame(height: 100)
                    
                    Text("Login")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    contentView
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            
            .navigationDestination(isPresented: $isLoginTapped) {
                TabContainerView()
            }
            .navigationDestination(isPresented: $isRegTapped) {
                RegisterView()
            }
        }
    }
    
    var contentView: some View {
        
        VStack(spacing: 20) {
            TextField("Enter email or user name here code in development", text: $userName)
                .roundedTextFieldStyle()
            SecureField("Password", text: $uaerPassword)
                .roundedTextFieldStyle()
            
            Text("adding one more line to check conflicts while merging in dev branch")
            
            Button(action: {
                loginAction()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        gradientColor(color1: .pink, color2: .blue, startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(10)
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
            .buttonStyle(.plain)
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                Button("Register here!") {
                    isRegTapped = true
                    
                }
                .foregroundColor(.purple)
                .bold()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding(.horizontal)
        
    }
    private func loginAction() {
        let loginUser = UserModel(userName: self.userName,
                                  userPassword: self.uaerPassword)
        
        if CoreDataManager.shared.fetchUser(userModel: loginUser) {
            print("Login successful")
            withAnimation(.easeInOut(duration: 0.5)) {
                session.isLoggedIn = true
                isLoginTapped = true
            }
        } else {
            print("Invalid username or password")
        }
    }
    
}


#Preview {
    LoginView()
}

