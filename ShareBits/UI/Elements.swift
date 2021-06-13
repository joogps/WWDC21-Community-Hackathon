//
//  Elements.swift
//  ShareBits (iOS)
//
//  Created by João Gabriel Pozzobon dos Santos on 13/06/21.
//

import SwiftUI

struct EmptyBit: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 35, style: .continuous)
            .stroke(.white, lineWidth: 4)
            .shadow(color: .white.opacity(0.75), radius: 5, x: 0, y: 0)
            .frame(width: 150.0, height: 150)
            .randomRotation()
    }
}

struct ColoredBit: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 35, style: .continuous)
            .fill(color)
            .shadow(color: color.opacity(0.75), radius: 5, x: 0, y: 0)
            .frame(width: 150, height: 150)
            .randomRotation()
    }
}

struct DoubledColoredBit: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 35, style: .continuous)
            .fill(color)
            .shadow(color: color.opacity(0.75), radius: 5, x: 0, y: 0)
            .frame(width: 300, height: 150)
            .randomRotation()
    }
}

struct EmptyBit_Previews: PreviewProvider {
    static var previews: some View {
        EmptyBit()
            .preferredColorScheme(.dark)
            .frame(width: 200.0, height: 200.0)
            .previewLayout(.sizeThatFits)
    }
}
