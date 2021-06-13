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
    }
}

struct ColoredBit: View {
    let color: Color
    let aspectRatio: Double
    
    init(color: Color, aspectRatio: Double = 1.0) {
        self.color = color
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 35, style: .continuous)
            .fill(color)
            .shadow(color: color.opacity(0.75), radius: 5, x: 0, y: 0)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .frame(height: 150)
    }
}

struct ColoredButton: View {
    let color: Color
    let systemName: String
    let aspectRatio: Double
    
    let action: () -> ()
    
    init(color: Color, systemName: String, aspectRatio: Double = 1.0, action: @escaping () -> () = {}) {
        self.color = color
        self.systemName = systemName
        self.action = action
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                ColoredBit(color: color, aspectRatio: aspectRatio)
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.secondary)
                    .foregroundColor(.black)
                    .font(.body.bold())
                    .padding(30)
            }.aspectRatio(aspectRatio, contentMode: .fit)
        }
    }
}

extension View {
    func randomRotation(amplitude: Double = 0.03) -> some View {
        return self.rotationEffect(.radians(.random(in: -Double.pi*amplitude...Double.pi*amplitude)))
    }
}
