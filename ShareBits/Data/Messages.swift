//
//  Messages.swift
//  ShareBits (iOS)
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import Foundation
import SwiftUI

struct ToggleBitMessage: Codable {
    let index: Int
    let active: Bool
    
    let red: Double
    let green: Double
    let blue: Double
}

struct CanvasMessage: Codable {
    let bits: [Bit]
    let title: String
}
