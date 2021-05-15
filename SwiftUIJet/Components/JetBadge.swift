//
//  JetBadge.swift
//  SwiftUIJet
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI

public struct JetBadge<Content: View>: View {
    var backgroundColor: Color = .red
    var textColor: Color = .white
    var text: String = ""
    var padding: CGFloat = 3
    var font: Font = .footnote
    var content: Content
    
    public init(padding: CGFloat = 3, backgroundColor: Color = .red, @ViewBuilder contentBuilder: () -> Content) {
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.content = contentBuilder()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .frame(minWidth: 24, minHeight: 24)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

extension JetBadge where Content == Text {
    public init(text: String?,
                backgroundColor: Color = .red,
                textColor: Color = .white,
                padding: CGFloat = 3,
                font: Font = .footnote)  {
        
        self.init() {
            Text(text ?? "")
                .font(font)
                .foregroundColor(textColor)
        }
        
        self.backgroundColor = backgroundColor
        self.text = text ?? ""
        self.textColor = textColor
        self.padding = padding
        self.font = font
    }
}

struct JetBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            JetBadge {
                Text("Custom content")
            }
            JetBadge(text: "Just badge")
            JetBadge(text: "With padding", padding: 10)
            Text("Default / top trailing").badge(count: 5)
            Text("Top leading").badge(count: 5, alignment: .topLeading)
            Text("Bottom leading").badge(count: 5, alignment: .bottomLeading)
            Text("Bottom trailing").badge(count: 5, alignment: .bottomTrailing)
            Text("Center").badge(count: 5, alignment: .center)
            Text("TopCenter").badge(count: 5, alignment: .top)
            Text("BottomCenter").badge(count: 5, color: .blue, alignment: .bottom)
        }
    }
}

public extension View {
    func badge(count: Int = 0, color: Color = .red, alignment: Alignment = .topTrailing) -> some View {
        let offset = calcBadgePosition(alignement: alignment)
        return ZStack(alignment: alignment) {
            self
            ZStack {
                if count != 0 {
                    JetBadge(text: "\(count)", backgroundColor: color)
                        .animation(nil)
                        .transition(.scale)
                }
            }
            .offset(x: offset.x, y: offset.y)
        }
    }
    
    func badge(text: String, color: Color = .red, alignment: Alignment = .topTrailing) -> some View {
        let offset = calcBadgePosition(alignement: alignment)
        return ZStack(alignment: alignment) {
            self
            ZStack {
                JetBadge(text: text, backgroundColor: color)
                    .animation(nil)
                    .transition(.scale)
            }
            .offset(x: offset.x, y: offset.y)
        }
    }
    
    private func calcBadgePosition(alignement: Alignment) -> CGPoint {
        let offset: CGFloat = 12
     
        switch alignement {
        case .topLeading:
            return CGPoint(x: -offset, y: -offset)
        case .topTrailing:
            return CGPoint(x: offset, y: -offset)
        case .bottomLeading:
            return CGPoint(x: -offset, y: offset)
        case .bottomTrailing:
            return CGPoint(x: offset, y: offset)
        case .top:
            return CGPoint(x: 0, y: -offset)
        case .bottom:
            return CGPoint(x: 0, y: offset)
        case .center:
            return CGPoint(x: 0, y: 0)
        default:
            return CGPoint(x: 0, y: 0)
        }
    }
}
