//
//  ShareBitsApp.swift
//  Shared
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import GroupActivities

@main
struct ShareBitsApp: App {
    // Objeto que contém os dados do quadro, assim como a tela atual
    @StateObject var canvas: Canvas = Canvas(currentScreen: .home)
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch canvas.currentScreen {
                case .home: HomeScreenView()
                case .canvas: CanvasView()
                }
            }.environmentObject(canvas)
        }
    }
}

enum CurrentScreen {
    case home
    case canvas
}
