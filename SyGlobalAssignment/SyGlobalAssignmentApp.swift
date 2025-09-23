//
//  SyGlobalAssignmentApp.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import SwiftUI

@main
struct SyGlobalAssignmentApp: App {
    @StateObject var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                TabContainerView()
                    .environmentObject(session)
            } else {
                LoginView()
                    .environmentObject(session)
            }
        }
    }
}
