//
//  Canvas.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import GroupActivities
import Combine

@MainActor
class Canvas: ObservableObject {
    @Published var currentScreen: CurrentScreen
    
    // Título do quadro
    @Published var title: String
    
    // Cor do usuário
    @Published var color: Color = .AppTheme.purple
    
    // Componentes da cor para transmissão
    var colorComponents: (red: Double, green: Double, blue: Double) {
        let components = color.cgColor?.components
        
        let red = components?[0] ?? 1.0
        let green = components?[1] ?? 1.0
        let blue = components?[2] ?? 1.0
        
        return (red: red, green: green, blue: blue)
    }
    
    // Definem o número de linhas e colunas da grade
    let cols: Int
    let rows: Int
    
    // Array com as informações sobre cada ponto
    @Published var bits: [Bit]
    
    // Session do SharePlay
    @Published var groupSession: GroupSession<GroupCanvasActivity>?
    
    // Messenger do SharePlay
    var messenger: GroupSessionMessenger?
    
    // Async
    var subscriptions = Set<AnyCancellable>()
    var tasks = Set<Task.Handle<Void, Never>>()
    
    init(currentScreen: CurrentScreen, title: String = "", cols: Int = 32, rows: Int = 32) {
        self.currentScreen = currentScreen
        
        self.title = title
        
        self.cols = cols
        self.rows = rows
        
        self.bits = []
        
        populateBits()
    }
    
    func toggleBit(index: Int) {
        bits[index].active.toggle()
        
        bits[index].red = colorComponents.red
        bits[index].green = colorComponents.green
        bits[index].blue = colorComponents.blue
        
        UIImpactFeedbackGenerator().impactOccurred(intensity: 0.5)
        
        if let messenger = messenger {
            let message = ToggleBitMessage(index: index, active: bits[index].active, red: colorComponents.red, green: colorComponents.green, blue: colorComponents.blue)
            
            async {
                do {
                    try await messenger.send(message)
                } catch {
                    // Pegou no pulo
                }
            }
        }
    }
    
    func populateBits() {
        for _ in 0...(cols*rows) {
            self.bits.append(Bit())
        }
    }
    
    func configureGroupSession(_ groupSession: GroupSession<GroupCanvasActivity>) async {
        self.groupSession = groupSession
        
        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger
        
        groupSession.$activeParticipants.sink { activeParticipants in
            let newParticipants = activeParticipants.subtracting(groupSession.activeParticipants)
            let message = CanvasMessage(bits: self.bits, title: self.title)
            
            async {
                do {
                    try await messenger.send(message, to: .only(newParticipants))
                } catch {
                    // Pegou no pulo
                }
            }
        }.store(in: &subscriptions)
        
        let toggleBitTask = detach { [weak self] in
            for await (message, _) in messenger.messages(of: ToggleBitMessage.self) {
                await self?.handle(message)
            }
        }
        tasks.insert(toggleBitTask)
        
        let canvasTask = detach { [weak self] in
            for await (message, _) in messenger.messages(of: CanvasMessage.self) {
                await self?.handle(message)
            }
        }
        tasks.insert(canvasTask)
        
        groupSession.join()
    }
    
    func handle(_ message: ToggleBitMessage) {
        bits[message.index].active = message.active
        
        bits[message.index].red = message.red
        bits[message.index].green = message.green
        bits[message.index].blue = message.blue
        
        UIImpactFeedbackGenerator().impactOccurred(intensity: 0.75)
    }
    
    func handle(_ message: CanvasMessage) {
        bits = message.bits
        title = message.title
    }
    
    func leaveSession() {
        messenger = nil
        
        tasks.forEach( { $0.cancel() } )
        tasks = []
        subscriptions = []
        
        if groupSession != nil {
            groupSession?.leave()
            groupSession = nil
        }
    }
}

enum CurrentScreen {
    case home
    case canvas
}


struct Bit: Identifiable, Codable {
    let id = UUID()
    
    var active = false
    
    var red: Double = 1.0
    var green: Double = 1.0
    var blue: Double = 1.0
}
