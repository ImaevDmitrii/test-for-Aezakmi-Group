//
//  AddTextBoxView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 07.08.2024.
//

import SwiftUI

struct AddTextBoxView: View {
    @EnvironmentObject var viewModel: PhotoEditorViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
            
            VStack {
                TextField(Localization.enterText, text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35))
                    .colorScheme(.dark)
                    .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .padding()
                
                HStack {
                    Button {
                        viewModel.toolPicker.setVisible(true, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.becomeFirstResponder()
                        withAnimation {
                            viewModel.addNewBox = false
                        }
                    } label: {
                        Text(Localization.addText)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Button {
                        viewModel.cancelTextView()
                    } label: {
                        Text(Localization.cancel)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .overlay(
                    HStack(spacing: 15) {
                        ColorPicker("", selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                            .labelsHidden()
                        Button(action: {
                            viewModel.textBoxes[viewModel.currentIndex].isBold.toggle()
                        }, label: {
                            Text(viewModel.textBoxes[viewModel.currentIndex].isBold ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                    }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}
