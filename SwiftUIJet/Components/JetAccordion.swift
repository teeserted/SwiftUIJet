//
//  JetAccordion.swift
//  SwiftUIJet
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI
public typealias JetAccordionItems = [JetAccordionItem]

public struct JetAccordionItem {
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
    
    var data: JetAccordionItems
    var renderHeader: HeaderRenderer
    var renderBody: BodyRenderer
    
    @State private var internalExpandedViewIdx: Int? = nil
    private var expandedViewIdx: Binding<Int?>?
    
    public init(expandedViewIdx: Binding<Int?>, data: JetAccordionItems, @ViewBuilder header: @escaping HeaderRenderer, @ViewBuilder body: @escaping BodyRenderer) {
        self.init(expandedViewIdx: .some(expandedViewIdx), data: data, header: header, body: body)
    }
    
    public init(data: JetAccordionItems, @ViewBuilder header: @escaping HeaderRenderer, @ViewBuilder body: @escaping BodyRenderer) {
        self.init(expandedViewIdx: nil, data: data, header: header, body: body)
    }
    
    private init(expandedViewIdx: Binding<Int?>?, data: JetAccordionItems, @ViewBuilder header: @escaping HeaderRenderer, @ViewBuilder body: @escaping BodyRenderer) {
        self.data = data
        self.renderHeader = header
        self.renderBody = body
        self.expandedViewIdx = expandedViewIdx
    }
    
    public var body: some View {
        JetAccordionInternal(
            expandedViewIdx: expandedViewIdx ?? $internalExpandedViewIdx,
            data: data,
            header: renderHeader,
            body: renderBody
        )
    }
}

private struct JetAccordionInternal<HeaderContent: View, BodyContent: View>: View {
    typealias HeaderRenderer = (JetAccordionItem, Bool) -> HeaderContent
    typealias BodyRenderer = (JetAccordionItem, Bool) -> BodyContent
    
    var data: JetAccordionItems
    var renderHeader: HeaderRenderer
    var renderBody: BodyRenderer
    var expandedViewIdx: Binding<Int?>

    public init(expandedViewIdx: Binding<Int?>, data: JetAccordionItems, @ViewBuilder header: @escaping HeaderRenderer, @ViewBuilder body: @escaping BodyRenderer) {
        self.renderHeader = header
        self.renderBody = body
        self.data = data
        self.expandedViewIdx = expandedViewIdx
    }
    
    public var body: some View {
        VStack {
            ForEach(Array(self.data.enumerated()), id: \.offset) { idx, item in
                VStack {
                    header(item, idx)
                    Divider()
                    body(item, idx)
                    if (isExpanded(idx)) {
                        Divider()
                    }
                }
            }
        }
    }
        
    private func header(_ item: JetAccordionItem, _ idx: Int) -> some View {
        let expanded = isExpanded(idx)
        let headerView = renderHeader(item, expanded)
       
        return Button(action: { headerTapped(idx) }, label: {
            if (headerView is EmptyView) {
                defaultHeader(item, expanded)
            } else {
                headerView
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func body(_ item: JetAccordionItem, _ idx: Int) -> some View {
        let expanded = isExpanded(idx)
        let bodyView = renderBody(item, expanded)
        
        var contentMaxHeight: CGFloat? {
            expanded ? nil : CGFloat(0)
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
    }
    
    private func defaultHeader(_ item: JetAccordionItem, _ isExpanded: Bool) -> some View {
        var rotation: Angle {
            let r: Double = isExpanded ? 180 : 0
            return Angle(degrees: r)
        }
        
        return HStack {
            Text(item.title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(rotation)
                .animation(.linear)
        }
        .padding()
        .padding(.bottom, 1)
        .background(Color.white.opacity(0.01))
    }
    
    private func defaultBody(_ item: JetAccordionItem,_ expanded: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
            }
            Text(item.content)
                .font(.body)
        }
        .padding()
    }
    
    private func isExpanded(_ idx: Int) -> Bool {
        return expandedViewIdx.wrappedValue == idx
    }
    
    private func headerTapped(_ idx: Int) {
        withAnimation(.easeOut) {
            if expandedViewIdx.wrappedValue == idx {
                expandedViewIdx.wrappedValue = nil
                return
            }
            expandedViewIdx.wrappedValue = idx
        }
    }
}

public extension JetAccordion where HeaderContent == EmptyView {
    init(data: JetAccordionItems, body: @escaping BodyRenderer) {
        self.init(data: data, header: { _,_ in EmptyView() }, body: body)
    }
    
    init(expandedViewIdx: Binding<Int>, data: JetAccordionItems, body: @escaping BodyRenderer) {
        self.init(data: data, header: { _,_ in EmptyView() }, body: body)
    }
}

public extension JetAccordion where BodyContent == EmptyView {
    init(data: JetAccordionItems, header: @escaping HeaderRenderer) {
        self.init(data: data, header: header, body: { _,_ in EmptyView() })
    }
    
    init(expandedViewIdx: Binding<Int?>, data: JetAccordionItems, header: @escaping HeaderRenderer) {
        self.init(expandedViewIdx: expandedViewIdx, data: data, header: header, body: { _,_ in EmptyView() })
    }
}

public extension JetAccordion where BodyContent == EmptyView, HeaderContent == EmptyView {
    init(data: JetAccordionItems) {
        self.init(data: data, header: { _,_ in EmptyView() }, body: { _,_ in EmptyView() })
    }
    
    init(expandedViewIdx: Binding<Int?>, data: JetAccordionItems) {
        self.init(expandedViewIdx: expandedViewIdx, data: data, header: { _,_ in EmptyView() }, body: { _,_ in EmptyView() })
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
