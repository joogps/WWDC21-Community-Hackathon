//
//  Data.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import GroupActivities

class Canvas: ObservableObject {
    // Título do quadro
    @Published var title: String
    
    // Definem o número de linhas e colunas da grade
    let cols: Int
    let rows: Int
    
    // Array com as informações sobre cada ponto
    @Published var bits: [Bit]
    
    // Session do SharePlay
    @Published var session: GroupSession<ShareBitsActivity>?
    
    init(title: String = "Canvas", cols: Int = 32, rows: Int = 32) {
        self.title = title
        
        self.cols = cols
        self.rows = rows
        
        self.bits = []
        
        for _ in 0...(cols*rows) {
            self.bits.append(Bit())
        }
    }
    
    func toggleBit(index: Int, color: Color = .white) {
        bits[index].active.toggle()
        bits[index].color = color
    }
    
    func configureSession(session: GroupSession<ShareBitsActivity>) {
        self.session = session
        self.session?.join()
    }
}

struct Bit: Identifiable {
    let id = UUID()
    
    var active = false
    var color = Color.white
}
