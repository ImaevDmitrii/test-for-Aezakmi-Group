//
//  FilterSelectionView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 07.08.2024.
//

import SwiftUI

struct FilterSelectionView: View {
    @ObservedObject var viewModel: PhotoEditorViewModel

    let filters: [CIFilter] = [
        CIFilter.sepiaTone(),
        CIFilter.gaussianBlur(),
        CIFilter.colorInvert(),
        CIFilter.photoEffectNoir(),
        CIFilter.photoEffectChrome()
    ]

    var body: some View {
        VStack {
            ForEach(filters, id: \.name) { filter in
                AuthButton(title: filter.name) {
                    viewModel.applySelectedFilter(filter)
                    viewModel.showFilterSheet = false
                }
                .padding()
            }
            AuthButton(title: "Original") {
                viewModel.resetCanvas()
                viewModel.showFilterSheet = false
            }
            .padding()
        }
    }
}
