//
//  EditorViews.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 07.08.2024.
//

import SwiftUI

struct EditorButton: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .padding(10)
        }
        .modifier(ButtonModifier())
    }
}
