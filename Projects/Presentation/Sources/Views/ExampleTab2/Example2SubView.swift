//
//  Example2SubView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/09.
//  Copyright © 2023 gb. All rights reserved.
//

import SwiftUI

public struct Example2SubView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.BG_Default
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct Example2SubView_Previews: PreviewProvider {
    static var previews: some View {
        Example2SubView()
    }
}
