//
//  HomeGourmetViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeGourmetViewComponent: View {
    
    var list: GourmetList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(list.categoryID.capitalized)
                .font(.system(size: 14, weight: .bold))
            
            ForEach(list.items, id: \.id) { (gourmet: GourmetItem) in
                ZStack {
                    Color.white
                    
                    HStack(alignment: .top) {
                        
                        GourmetDescriptionViewComponent(
                            name: gourmet.name,
                            description: gourmet.itemDescription,
                            tags: gourmet.tags,
                            isDiscount: gourmet.isDiscount,
                            displayPrice: gourmet.displayPrice.description,
                            originalPrice: gourmet.price.description
                        )
                        
                        Spacer()
                        
                        WebImage(url: URL(string: gourmet.imageURL))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120)
                            .clipped()
                    }
                }
                .frame(height: 160)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
            }
        }
        .padding()
    }
}
