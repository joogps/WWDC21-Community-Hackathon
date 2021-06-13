//
//  HomeScreenView.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        ZStack {
            Color.AppTheme.background
            
            VStack(spacing: 25) {
                Spacer()
                emptyBitRow
                settingsRow
                playRow
                emptyBitRow
                Spacer()
            }
        }.ignoresSafeArea()
    }
    
    var playRow: some View {
        HStack(spacing: 25) {
            ColoredBit(color: .AppTheme.blue)
            DoubledColoredBit(color: .AppTheme.red)
            ColoredBit(color: .AppTheme.purple)
        }
    }
    
    var settingsRow: some View {
        HStack(spacing: 25) {
            ColoredBit(color: .AppTheme.purple)
            ColoredButton(color: .AppTheme.green, systemName: "paintbrush.fill")
            ColoredButton(color: .AppTheme.blue, systemName: "questionmark")
            ColoredBit(color: .AppTheme.red)
        }
    }
    
    var emptyBitRow: some View {
        HStack(spacing: 25) {
            EmptyBit()
            EmptyBit()
            EmptyBit()
            EmptyBit()
        }
    }
}

struct ColoredButton: View {
    let color: Color
    let systemName: String
    let action: () -> () = {}
    
    var body: some View {
        ZStack {
            ColoredBit(color: color)
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.secondary)
                .foregroundColor(.black)
                .font(.body.bold())
                .padding(30)
        }.aspectRatio(1.0, contentMode: .fit)
    }
}

extension View {
    func randomRotation(amplitude: Double = 0.03) -> some View {
        return self.rotationEffect(.radians(.random(in: -Double.pi*amplitude...Double.pi*amplitude)))
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
