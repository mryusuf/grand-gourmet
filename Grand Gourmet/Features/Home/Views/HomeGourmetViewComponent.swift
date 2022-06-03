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
                        VStack(alignment: .leading, spacing: 8) {
                            Text(gourmet.name.capitalized)
                                .font(.system(size: 12, weight: .semibold))
                            
                            Text(gourmet.itemDescription)
                                .font(.system(size: 10))
                            
                            TagViewComponent(tags: gourmet.tags)
                            
                            Text("SDG \(gourmet.price.description)")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .padding(.init(top: 16, leading: 16, bottom: 10, trailing: 10))
                        
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
