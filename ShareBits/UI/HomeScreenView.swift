//
//  HomeScreenView.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI
import SlideOverCard
import CoreMedia

struct HomeScreenView: View {
    @State var currentCard: Cards? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.AppTheme.background
                
                VStack(spacing: 25) {
                    Spacer()
                    emptyBitRow
                    playRow
                    settingsRow
                    emptyBitRow
                    Spacer()
                }
            }.ignoresSafeArea()
                .frame(maxWidth: geo.size.width)
        }.slideOverCard(item: $currentCard, options: [.hideExitButton], content: { item in
            switch item {
            case .color: ColorPickerView(currentCard: $currentCard)
            case .help: Text("how does it work")
            case .setup: SetupView(currentCard: $currentCard)
            }
        })
    }
    
    var playRow: some View {
        HStack(spacing: 25) {
            ColoredBit(color: .AppTheme.blue).randomRotation()
            ColoredButton(color: .AppTheme.red, systemName: "shareplay", aspectRatio: 2.0, action: {
                withAnimation {
                    currentCard = .setup
                }
            }).randomRotation()
            ColoredBit(color: .AppTheme.yellow).randomRotation()
        }
    }
    
    var settingsRow: some View {
        HStack(spacing: 25) {
            ColoredBit(color: .AppTheme.purple)
                .randomRotation()
            ColoredButton(color: .AppTheme.green, systemName: "paintbrush.fill", action: {
                withAnimation {
                    currentCard = .color
                }
            }).randomRotation()
            ColoredButton(color: .AppTheme.blue, systemName: "questionmark", action: {
                withAnimation {
                    currentCard = .help
                }
            }).randomRotation()
            ColoredBit(color: .AppTheme.red)
                .randomRotation()
        }
    }
    
    var emptyBitRow: some View {
        HStack(spacing: 25) {
            EmptyBit().randomRotation()
            EmptyBit().randomRotation()
            EmptyBit().randomRotation()
            EmptyBit().randomRotation()
        }
    }
}

struct ColorPickerView: View {
    @EnvironmentObject var canvas: Canvas
    @Binding var currentCard: Cards?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("pick your color").monospacedTitle()
            
            HStack(spacing: 10) {
                ForEach(Color.AppTheme.themeColors, id: \.self) { color in
                    ZStack {
                        if canvas.color == color {
                            Circle().fill(color).padding(8)
                            Circle().stroke(color, lineWidth: 4).padding(2)
                        } else {
                            Circle().fill(color)
                        }
                    }.onTapGesture {
                        canvas.color = color
                    }
                }
            }
            
            Button("\(Text("done").font(.system(.body).weight(.heavy)))", action: {
                withAnimation {
                    currentCard = nil
                }
            }).buttonStyle(SOCActionButton(textColor: .black))
        }.frame(height: 200)
    }
}

struct SetupView: View {
    @EnvironmentObject var canvas: Canvas
    @Binding var currentCard: Cards?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("name your canvas").monospacedTitle()
            
            TextField("Group canvas", text: $canvas.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("\(Text("start").font(.system(.body).weight(.heavy)))", action: {
                if canvas.title.isEmpty {
                    canvas.title = "Group canvas"
                }
                
                GroupCanvasActivity(name: canvas.title).activate()
                withAnimation {
                    currentCard = nil
                }
            }).buttonStyle(SOCActionButton(textColor: .black))
        }
    }
}

extension Text {
    func monospacedTitle() -> Text {
        return self.font(.system(size: 32, weight: .bold, design: .monospaced)).kerning(-2.5)
    }
}

enum Cards: Identifiable {
    var id: Self { self }
    
    case color
    case help
    case setup
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
