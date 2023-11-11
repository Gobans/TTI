//
//  HomeView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

public struct ExampleTab1View: View {
    
    @ObservedObject private(set) var viewModel: ExampleTab1ViewModel
    
    public init(viewModel: ExampleTab1ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.BG_Default
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.bottom, 30)
                } else {
                    Text(viewModel.slip.advice)
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                }
                Button("Change Quote") {
                    self.viewModel.onChangeQuoteButtonClicked()
                }
            }
        }
        .onAppear {
            self.viewModel.onChangeQuoteButtonClicked()
        }
    }
}
