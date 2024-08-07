//
//  ViewModifiers.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding(.horizontal, 10)
    }
}

struct SubtitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.bottom, 20)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
