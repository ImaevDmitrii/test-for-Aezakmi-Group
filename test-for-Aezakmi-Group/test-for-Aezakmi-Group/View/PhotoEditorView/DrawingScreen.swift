//
//  DrawingScreen.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var viewModel: PhotoEditorViewModel
    @State private var blurAmount = 0.0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.frame(in: .global).size
                ZStack {
                    CanvasView(canvas: $viewModel.canvas, imageData: $viewModel.image, toolPicker: $viewModel.toolPicker, rect: size)
                        .frame(width: size.width, height: size.height, alignment: .center)
                    
                    ForEach(viewModel.textBoxes) { box in
                        Text(viewModel.textBoxes[viewModel.currentIndex].id == box.id && viewModel.addNewBox ? "" : box.text)
                            .font(.system(size: 30))
                            .fontWeight(box.isBold ? .bold : .none)
                            .foregroundColor(box.textColor)
                            .offset(box.offset)
                            .gesture(DragGesture().onChanged { value in
                                let current = value.translation
                                let lastOffset = box.lastOffset
                                let newTranslation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                                viewModel.textBoxes[getIndex(textBox: box)].offset = newTranslation
                            }
                            .onEnded { value in
                                viewModel.textBoxes[getIndex(textBox: box)].lastOffset = viewModel.textBoxes[getIndex(textBox: box)].offset
                            })
                            .onLongPressGesture {
                                viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                                viewModel.canvas.resignFirstResponder()
                                viewModel.currentIndex = getIndex(textBox: box)
                                withAnimation {
                                    viewModel.addNewBox = true
                                }
                            }
                    }
                }
                .onAppear {
                    if viewModel.rect == .zero {
                        viewModel.rect = CGRect(origin: .zero, size: size)
                    }
                }
            }
        }
    }
    
    func getIndex(textBox: TextBox) -> Int {
        return viewModel.textBoxes.firstIndex { $0.id == textBox.id } ?? 0
    }
}
