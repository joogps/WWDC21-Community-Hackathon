//
//  BitView.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI

struct BitView: View {
    let bit: Bit
    
    var body: some View {
        ZStack {
            inactive
            
            if bit.active {
                active
            }
        }.aspectRatio(1.0, contentMode: .fill)
    }
    
    var active: some View {
        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.white)
            .transition(.scale)
    }
    
    var inactive: some View {
        RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(.white, lineWidth: 0.25)
    }
}
