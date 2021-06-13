//
//  HomeScreenView.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import IrregularGradient

struct HomeScreenView: View {
    @EnvironmentObject var canvas: Canvas
    
    var body: some View {
        ZStack {
            // Renderiza o fundo irregular animado do package do Swift que a gente vai usar
            IrregularGradient(colors: [Color.AppTheme.primary, Color.AppTheme.primary, Color.AppTheme.primary], background: Color.AppTheme.background).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("ShareBits").font(.system(size: 40, weight: .bold, design: .monospaced)).kerning(-3)
                
                Button(action: {
                    ShareBitsActivity().activate()
                }) {
                    ZStack {
                        Circle().fill(.white)
                        Image(systemName: "person.3.fill").resizable()
                            .foregroundStyle(.black)
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(0.25)
                    }.scaleEffect(0.5)
                }
                
                Spacer()
            }
        }.task {
            for await session in ShareBitsActivity.sessions() {
                await canvas.configureSession(session)
                if canvas.session?.state == .waiting {
                    canvas.currentScreen = .canvas
                }
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
