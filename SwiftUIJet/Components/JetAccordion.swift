//
//  JetAccordion.swift
//  SwiftUIJet
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI

public struct JetAccordionItem: Hashable {
    let id = UUID()
    public let title: String
    public let content: String
    
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

public struct JetAccordion<HeaderContent: View, BodyContent: View>: View {
    public typealias HeaderRenderer = (JetAccordionItem, Bool) -> HeaderContent
    public typealias BodyRenderer = (JetAccordionItem, Bool) -> BodyContent
    public typealias JetAccordionItems = [JetAccordionItem]
    
    var data: [JetAccordionItem]
    var renderHeader: HeaderRenderer
    var renderBody: BodyRenderer
    @State private var expandedViewId: UUID?

    public init(data: JetAccordionItems, @ViewBuilder header: @escaping HeaderRenderer, @ViewBuilder body: @escaping BodyRenderer) {
        self.renderHeader = header
        self.renderBody = body
        self.data = data
    }
    
    public var body: some View {
        VStack {
            ForEach(data, id: \.id) { item in
                VStack {
                    header(item)
                    body(item)
                }
            }
        }
    }
    
    private func header(_ item: JetAccordionItem) -> some View {
        let expanded = isExpanded(item)
        let headerView = renderHeader(item, expanded)
       
        return Button(action: { headerTapped(item) }, label: {
            if (headerView is EmptyView) {
                defaultHeader(item, expanded)
            } else {
                headerView
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func body(_ item: JetAccordionItem) -> some View {
        let expanded = isExpanded(item)
        let bodyView = renderBody(item, expanded)
        
        var contentMaxHeight: CGFloat? {
            expanded ? nil : 0
        }
                
        return VStack {
            if (expanded) {
                if (bodyView is EmptyView) {
                    defaultBody(item, expanded)
                } else {
                    bodyView
                }
            }
        }
        .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: contentMaxHeight)
        .clipped()
        .animation(.easeOut)
        .transition(.slide)
    }
    
    private func defaultHeader(_ item: JetAccordionItem, _ isExpanded: Bool) -> some View {
        var iconName: String {
            isExpanded ? "chevron.up" : "chevron.down"
        }
        return HStack {
            Text(item.title)
            Spacer()
            Image(systemName: iconName)
        }
        .padding(.bottom, 1)
        .background(Color.white.opacity(0.01))
    }
    
    private func defaultBody(_ item: JetAccordionItem,_ expanded: Bool) -> some View {
        Text(item.content)
    }
    
    private func isExpanded(_ item: JetAccordionItem) -> Bool {
        return expandedViewId == item.id
    }
    
    private func headerTapped(_ item: JetAccordionItem) {
        if expandedViewId == item.id {
            expandedViewId = nil
            return
        }
        expandedViewId = item.id
    }
}

public extension JetAccordion where HeaderContent == EmptyView {
    init(data: JetAccordionItems, body: @escaping BodyRenderer) {
        self.init(data: data, header: { _,_ in EmptyView() }, body: body)
    }
}

public extension JetAccordion where BodyContent == EmptyView {
    init(data: JetAccordionItems, header: @escaping HeaderRenderer) {
        self.init(data: data, header: header, body: { _,_ in EmptyView() })
    }
}

public extension JetAccordion where BodyContent == EmptyView, HeaderContent == EmptyView {
    init(data: JetAccordionItems) {
        self.init(data: data, header: { _,_ in EmptyView() }, body: { _,_ in EmptyView() })
    }
}

struct JetAccordion_Previews: PreviewProvider {
    static var previews: some View {
        let testData = [
            JetAccordionItem(title: "Header 1", content: "Content 1"),
            JetAccordionItem(title: "Header 2", content: "Content 2")
        ]
        return JetAccordion(data: testData)
    }
}
