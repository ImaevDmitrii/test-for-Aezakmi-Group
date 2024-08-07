//
//  TextBox.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI

struct TextBox: Identifiable {
    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    var isAdded: Bool = false
}
