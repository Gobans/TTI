//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    private let tab1: ExampleTab1View
    private let tab2: ExampleTab2View
    @State private var selection: Int = 1
    
    public init(tab1: ExampleTab1View, tab2: ExampleTab2View) {
        self.tab1 = tab1
        self.tab2 = tab2
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            tab1
                .tabItem {
                    VStack {
                        Image(systemName: "hexagon.fill")
                        Text("Tab1")
                    }
                }
                .tag(1)
            tab2
                .tabItem {
                    VStack {
                        Image(systemName: "pentagon.fill")
                        Text("Tab2")
                    }
                }
                .tag(2)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(.white)
        }
    }
}
