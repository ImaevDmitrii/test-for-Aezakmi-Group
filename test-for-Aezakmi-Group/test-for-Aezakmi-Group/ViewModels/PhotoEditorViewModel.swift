//
//  PhotoEditorViewModel.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PencilKit
import Combine
import Photos

final class PhotoEditorViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var showCameraPicker = false
    @Published var image: UIImage? {
        didSet {
            if originalImage == nil {
                originalImage = image
            }
        }
    }
    @Published var originalImage: UIImage?
    @Published var isEditing = false
    @Published var textBoxes: [TextBox] = []
    @Published var addNewBox = false
    @Published var currentIndex = 0
    @Published var showAlert = false
    @Published var message = ""
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    @Published var rect: CGRect = .zero
    @Published var showFilterSheet = false
    
    private let context = CIContext()
    
    func addNewTextBox() {
        textBoxes.append(TextBox())
        currentIndex = textBoxes.count - 1
        withAnimation {
            addNewBox = true
        }
        toolPicker.setVisible(false, forFirstResponder: canvas)
        canvas.resignFirstResponder()
    }
    
    func applyFilter(to inputImage: UIImage, filter: CIFilter) -> UIImage? {
        let ciImage = CIImage(image: inputImage)
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    func combineImageWithCanvas() -> UIImage? {
        guard let baseImage = image else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: baseImage.size)
        
        return renderer.image { context in
            baseImage.draw(at: .zero)
            
            let canvasImage = canvas.drawing.image(from: canvas.bounds, scale: UIScreen.main.scale)
            canvasImage.draw(in: CGRect(origin: .zero, size: baseImage.size))
            
            for textBox in textBoxes where textBox.isAdded {
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 20, weight: textBox.isBold ? .bold : .regular),
                    .foregroundColor: UIColor(textBox.textColor)
                ]
                
                let attributedString = NSAttributedString(string: textBox.text, attributes: attributes)
                let textRect = CGRect(x: textBox.offset.width, y: textBox.offset.height, width: baseImage.size.width, height: baseImage.size.height)
                attributedString.draw(in: textRect)
            }
        }
    }
    
    func saveImage() {
        guard let combinedImage = combineImageWithCanvas() else { return }
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                UIImageWriteToSavedPhotosAlbum(combinedImage, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            case .denied, .restricted, .notDetermined:
                DispatchQueue.main.async {
                    self.message = "Permission to access photo library is required to save images."
                    self.showAlert = true
                }
            @unknown default:
                DispatchQueue.main.async {
                    self.message = "Unknown error occurred."
                    self.showAlert = true
                }
            }
        }
    }
    
    func shareImage() {
        guard let combinedImage = combineImageWithCanvas() else { return }
        
        let activityVC = UIActivityViewController(activityItems: [combinedImage], applicationActivities: nil)
        
        if let topController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController {
            topController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            DispatchQueue.main.async {
                self.message = "Failed to save image: \(error.localizedDescription)"
                self.showAlert = true
            }
        } else {
            DispatchQueue.main.async {
                self.message = "Image saved to photo library!"
                self.showAlert = true
            }
        }
    }
    
    func showFilterOptions() {
        showFilterSheet = true
    }
    
    func applySelectedFilter(_ filter: CIFilter) {
        let canvasImage = canvas.drawing.image(from: canvas.bounds, scale: UIScreen.main.scale)
        if let filteredImage = applyFilter(to: canvasImage, filter: filter) {
            image = filteredImage
            updateCanvas(with: filteredImage)
        } else {
            message = "Failed to apply filter!"
            showAlert = true
        }
    }
    
    func updateCanvas(with image: UIImage) {
        let drawing = PKDrawing()
        let imageView = UIImageView(image: image)
        imageView.frame = canvas.bounds
        UIGraphicsBeginImageContextWithOptions(canvas.bounds.size, false, UIScreen.main.scale)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        drawing.image(from: canvas.bounds, scale: UIScreen.main.scale).draw(at: .zero)
        UIGraphicsEndImageContext()
        canvas.drawing = drawing
    }
    
    func resetCanvas() {
        canvas.drawing = PKDrawing()
    }
    
    func cancelImageEditing() {
        withAnimation {
            self.image = nil
        }
    }
    
    func cancelTextView() {
        withAnimation {
            addNewBox = false
        }
    }
}
