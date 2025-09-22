//
//  SessionManger.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 22/09/25.
//

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
}
