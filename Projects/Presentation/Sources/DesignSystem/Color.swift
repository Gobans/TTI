//
//  Color.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/09.
//  Copyright © 2023 gb. All rights reserved.
//

import SwiftUI

public enum AppColor: String {
    case BG_Default
}

extension Color {
    
    /// hex: #FAFAFA
    static let BG_Default = makeColor(.BG_Default)
}

extension Color {
    
    static func makeColor(_ color: AppColor) -> Color {
        return Color(color.rawValue, bundle: Bundle.module)
    }
    
}

extension ShapeStyle where Self == Color {
    static var BG_Default: Color { Color.BG_Default }
}
