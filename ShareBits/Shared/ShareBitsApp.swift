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
    @State var currentScreen: CurrentScreen = .home
    @StateObject var canvas: Canvas = Canvas()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch currentScreen {
                case .home: HomeScreenView()
                case .canvas: CanvasView()
                }
            }.task {
                for await session in ShareBitsActivity.sessions() {
                    canvas.configureSession(session: session)
                    print(canvas.session)
                }
            }.environmentObject(canvas)
        }
    }
}

enum CurrentScreen {
    case home
    case canvas
}
