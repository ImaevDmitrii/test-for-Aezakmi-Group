//
//  PhotoEditorView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI
import PencilKit

struct PhotoEditorView: View {
    @StateObject var viewModel = PhotoEditorViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if let _ = viewModel.image {
                        Spacer(minLength: 15)
                        
                        HStack(spacing: 20) {
                            EditorButton(iconName: "textformat") {
                                viewModel.addNewTextBox()
                            }
                            
                            EditorButton(iconName: "square.and.arrow.up") {
                                viewModel.shareImage()
                            }
                            
                            EditorButton(iconName: "tray.and.arrow.down") {
                                viewModel.saveImage()
                            }
                            
                            EditorButton(iconName: "slider.horizontal.3") {
                                viewModel.showFilterOptions()
                            }
                            
                            EditorButton(iconName: "xmark") {
                                viewModel.cancelImageEditing()
                                viewModel.resetCanvas()
                                viewModel.image = nil
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        
                        Spacer(minLength: 20)
                        
                        DrawingScreen()
                            .environmentObject(viewModel)
                            .padding(.bottom, 20)
                    } else {
                        HStack(spacing: 20) {
                            EditorButton(iconName: "camera") {
                                viewModel.showCameraPicker = true
                            }
                            
                            EditorButton(iconName: "photo.fill") {
                                viewModel.showImagePicker.toggle()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 20)
                    }
                }
                .navigationBarHidden(true)
                .sheet(isPresented: $viewModel.showCameraPicker) {
                    CameraView(image: $viewModel.image)
                }
            }
            if viewModel.addNewBox {
                AddTextBoxView()
                    .environmentObject(viewModel)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.image)
        }
        .sheet(isPresented: $viewModel.showFilterSheet) {
            FilterSelectionView(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(Localization.message), message: Text(viewModel.message), dismissButton: .destructive(Text(Localization.okText)))
        }
    }
}

struct PhotoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditorView()
    }
}
