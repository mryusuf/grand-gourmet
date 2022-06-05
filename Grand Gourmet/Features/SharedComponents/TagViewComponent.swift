//
//  TagViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import SwiftUI

struct TagViewComponent: View {
    
    var tags: [String]
    
    @State private var totalHeight
    = CGFloat.zero
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.vertical, .trailing], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some View {
        Text(text)
            .font(.system(size: 9, weight: .semibold))
            .padding(.init(top: 2, leading: 4, bottom: 2, trailing: 4))
            .background(Color.blue.opacity(0.2))
            .foregroundColor(Color.blue)
            .cornerRadius(4)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

//struct TagViewComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        TagViewComponent(title: "Gluten-Free")
//    }
//}

