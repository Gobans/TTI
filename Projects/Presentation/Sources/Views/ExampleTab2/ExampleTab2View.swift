//
//  ExampleTab2View.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/09.
//  Copyright © 2023 gb. All rights reserved.
//

import SwiftUI
import Domain

public struct ExampleTab2View: View {
    
    @ObservedObject private(set) var viewModel: ExampleTab2ViewModel
    
    public init(viewModel: ExampleTab2ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.BG_Default
            VStack {
                Button("Move to next View") {
                    self.viewModel.moveToExampleSubView()
                }
            }
        }
    }
}
