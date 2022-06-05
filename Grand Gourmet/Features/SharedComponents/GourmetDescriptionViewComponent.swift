//
//  GourmetDescriptionViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import SwiftUI

struct GourmetDescriptionViewComponent: View {
    
    var name: String
    var description: String
    var tags: [String]
    var isDiscount: Bool
    var displayPrice: String
    var originalPrice: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name.capitalized)
                .font(.subheadline)
            
            Text(description)
                .font(.system(size: 10).weight(.light))
            
            TagViewComponent(tags: tags)
            
            if isDiscount {
                HStack {
                    Text("SGD \(displayPrice)")
                        .font(.caption.bold())
                    
                    Text("SGD \(originalPrice)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                Text("SGD \(displayPrice)")
                    .font(.caption.bold())
            }
        }
        .foregroundColor(Color.black)
    }
}
