//
//  CanvasView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var imageData: UIImage?
    @Binding var toolPicker: PKToolPicker
    
    var rect: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = imageData {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            canvas.addSubview(imageView)
            canvas.sendSubviewToBack(imageView)
        }
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if let imageView = uiView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            imageView.frame = CGRect(origin: .zero, size: rect)
        }
    }
}
