//
//  CanvasView.swift
//  Shared
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import IrregularGradient

struct CanvasView: View {
    @EnvironmentObject var canvas: Canvas
    
    // Espaçamento das células
    let spacing = 3.0
    
    // Necessário para o layout da grade
    var gridLayout: [GridItem] {
        .init(repeating: GridItem(.flexible(), spacing: spacing), count: canvas.cols)
    }
    
    // Modo de visualização
    @State var viewingMode: ContentMode = .fill
    
    var body: some View {
        Group {
            GeometryReader { geo in
                Group {
                    if let bits = canvas.bits {
                        LazyVGrid(columns: gridLayout, spacing: spacing) {
                            ForEach (bits.indices) { index in
                                BitView(bit: bits[index])
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.1)) {
                                            canvas.toggleBit(index: index)
                                        }
                                }
                            }
                        }.aspectRatio(1.0, contentMode: .fill)
                    }
                }
            }
        }.safeAreaInset(edge: .top, content: {
            toolbar
        }).ignoresSafeArea()
        .background(Color.AppTheme.background.ignoresSafeArea())
    }
    
    var toolbar: some View {
        ZStack(alignment: .bottom) {
            Rectangle().fill(.ultraThinMaterial)
            
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(canvas.title)
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
    }
}
