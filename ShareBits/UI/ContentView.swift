//
//  ContentView.swift
//  ShareBits (iOS)
//
//  Created by João Gabriel Pozzobon dos Santos on 13/06/21.
//

import SwiftUI

struct ContentView: View {
    // Objeto que contém os dados do quadro, assim como a tela atual
    @StateObject var canvas: Canvas = Canvas(currentScreen: .home)
    
    var body: some View {
        Group {
            switch canvas.currentScreen {
            case .home: HomeScreenView()
            case .canvas: CanvasView()
            }
        }.environmentObject(canvas)
        .colorScheme(.dark)
        .accentColor(canvas.color)
        .task {
            for await session in GroupCanvasActivity.sessions() {
                await canvas.configureGroupSession(session)
                
                withAnimation {
                    canvas.currentScreen = .canvas
                }
            }
        }
    }
}
