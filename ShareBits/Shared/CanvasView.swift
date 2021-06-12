//
//  CanvasView.swift
//  Shared
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import IrregularGradient

struct CanvasView: View {
    let cols = 28
    let rows = 28
    
    let gridLayout: [GridItem] = .init(repeating: GridItem(.flexible(), spacing: 3), count: 28)
    
    @State var translate = 0.0
    
    @State var bits: [Bit]?
    
    @State var viewingMode: ContentMode = .fill
    
    var body: some View {
        Group {
            GeometryReader { geo in
                Group {
                    if let bits = bits {
                        LazyVGrid(columns: gridLayout, spacing: 3) {
                            ForEach (bits.indices) { index in
                                BitView(bit: bits[index])
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                    toggleBit(index: index)
                                }
                            }
                        }.aspectRatio(1.0, contentMode: viewingMode)
                    }
                }.frame(maxWidth: geo.size.width)
            }
        }.safeAreaInset(edge: .top, content: {
            ZStack(alignment: .bottom) {
                Rectangle().fill(.ultraThinMaterial)
                
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Text("A smiley face")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .kerning(-1)
                    Spacer()
                    Image(systemName: "square.grid.3x3.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.padding(12)
                    .foregroundStyle(.secondary)
                .frame(height: 50)
            }.frame(height: 100)
        }).ignoresSafeArea()
        .onAppear {
            bits = populatedBits(cols: cols, rows: rows)
        }.background(Color.AppTheme.background.ignoresSafeArea())
    }
    
    func populatedBits(cols: Int, rows: Int) -> [Bit] {
        var bits = [Bit]()
        let total = cols*rows
        
        for _ in 0..<total {
            bits.append(Bit())
        }
        
        return bits
    }
    
    func toggleBit(index: Int) {
        bits?[index].active.toggle()
        
    }
}

struct Bit: Identifiable {
    let id = UUID()
    
    var active = false
    var color = Color.white
}

extension Color {
  struct AppTheme {
      static var yellow = Color(red: 255/255.0, green: 230.0/255.0, blue: 164.0/255.0)
      static var green = Color(red: 203.0/255.0, green: 255.0/255.0, blue: 219.0/255.0)
      static var purple = Color(red: 180.0/255.0, green: 158.0/255.0, blue: 255.0/255.0)
      static var red = Color(red: 255.0/255.0, green: 172.0/255.0, blue: 172.0/255.0)
      static var blue = Color(red: 161.0/255.0, green: 254.0/255.0, blue: 255.0/255.0)
      
      static var background = Color(red: 2.0/255.0, green: 11.0/255.0, blue: 37.0/255.0)
  }
}
