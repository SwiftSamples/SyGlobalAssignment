//
//  OrderCell.swift
//  SyGlobalAssignment
//
//  Created by Swapna Botta on 21/09/25.
//

import Foundation
import SwiftUI


extension View {
    func roundedTextFieldStyle() -> some View {
        self
            .padding()
            .background(Color.white.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple.opacity(0.5), lineWidth: 1)
            )
            .cornerRadius(8)
            .padding(.horizontal, 7)
    }
}


func gradientColor(
    color1: Color,
    color2: Color,
    startPoint: UnitPoint = .topLeading,
    endPoint: UnitPoint = .bottomTrailing
) -> LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [color1, color2]),
        startPoint: startPoint,
        endPoint: endPoint
    )
}


struct CustomHeaderView: View {
    var title: String
    var onBack: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            // Back button
            Button(action: {
                onBack?()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(.leading)
            }
            
            Spacer()
            
            // Title
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Invisible button for alignment
            Image(systemName: "chevron.left")
                .opacity(0)
                .padding(.trailing)
        }
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}
