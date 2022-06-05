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
    
    @State var showSheetView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(list.categoryID.capitalized)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 0))
            
            if list.categoryID == "popular" {
                popularSectionViewComponent
            } else {
                otherSectionViewComponent
            }
        }
    }
}

extension HomeGourmetViewComponent {
    
    var popularSectionViewComponent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(list.items, id: \.id) { (gourmet: GourmetItem) in
                    
                    VStack(alignment: .leading) {
                    
                        ZStack(alignment: .topTrailing) {
                            WebImage(url: URL(string: gourmet.imageURL))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 120)
                                .clipped()
                            
                            if gourmet.isDiscount {
                                discountViewComponent(discount: gourmet.discountPercent.description)
                            }
                        }
                        
                        GourmetDescriptionViewComponent(
                            name: gourmet.name,
                            description: gourmet.itemDescription,
                            tags: gourmet.tags,
                            isDiscount: gourmet.isDiscount,
                            displayPrice: gourmet.displayPrice.description,
                            originalPrice: gourmet.price.description
                        )
                        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                        
                        Spacer()
                        
                    }
                    .background(Color.white)
                    .frame(width: 200, height: 300)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
                    .onTapGesture {
                        self.showSheetView.toggle()
                    }
                    .sheet(isPresented: $showSheetView) {
                        GourmetDetailView(
                            viewModel: GourmetDetailViewModel()
                        )
                    }
                    .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 0))
                }
            }
        }
    }
    
    var otherSectionViewComponent: some View {
        ForEach(list.items, id: \.id) { (gourmet: GourmetItem) in
            
            HStack(alignment: .top) {
            
                GourmetDescriptionViewComponent(
                    name: gourmet.name,
                    description: gourmet.itemDescription,
                    tags: gourmet.tags,
                    isDiscount: gourmet.isDiscount,
                    displayPrice: gourmet.displayPrice.description,
                    originalPrice: gourmet.price.description
                )
                .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                
                Spacer()
                
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: gourmet.imageURL))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120)
                        .clipped()
                    
                    if gourmet.isDiscount {
                        discountViewComponent(discount: gourmet.discountPercent.description)
                    }
                }
            }
            .background(Color.white)
            .frame(height: 160)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
            .onTapGesture {
                self.showSheetView.toggle()
            }
            .sheet(isPresented: $showSheetView) {
                GourmetDetailView(
                    viewModel: GourmetDetailViewModel()
                )
            }
            .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
    }
    
    func discountViewComponent(discount: String) -> some View {
        Text("\(discount)%")
            .font(.caption2.bold())
            .foregroundColor(Color.white)
            .padding(.all, 4)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            .background(Color.red)
            .padding([.all], 10)
    }
}
