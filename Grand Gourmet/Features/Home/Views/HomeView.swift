//
//  HomeView.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    private var headerImageHeight: CGFloat {
        if scrollOffset < 0 {
            return 200
        } else if scrollOffset == 0 {
            return 180
        } else {
            return 100
        }
    }
    @State private var scrollOffset: CGFloat = .zero

    private let headerImageURL = "https://picsum.photos/id/0/5616/3744"
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    content
                    
                    cartViewComponent
                }
            }
            .ignoresSafeArea()
        }.onAppear {
            self.viewModel.fetchData()
        }
    }
}

extension HomeView {
    
    var content: some View {
        
        ScrollViewReader { scrollView in
            
            ZStack {
                
                WebImage(url: URL(string: headerImageURL))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: headerImageHeight)
                    .clipped()
                
                Color.black.opacity(0.4)
                
                VStack {
                    Text("Grand Gourmet")
                    
                    Text("Dining")
                }
                .foregroundColor(Color.white)
            }
            .frame(height: headerImageHeight)
            .padding([.bottom], -10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(
                        self.viewModel.gourmetCategories,
                        id: \.name
                    ) { category in
                        Button(category.name) {
                            scrollView.scrollTo(category.id)
                        }
                    }
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 0))
            }
            .background(Color.white
                .shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 5))
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(self.viewModel.gourmetList, id: \.categoryID) { (list: GourmetList) in
                        
                        HomeGourmetViewComponent(list: list)
                        
                    }.background(GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            scrollOffset = -proxy.frame(in: .named("scroll")).origin.y
                        }
                        return Color.clear
                    })
                }
            }
            .coordinateSpace(name: "scroll")
            
            
        }
        .background(Color.black.opacity(0.06))
    }
    
    var cartViewComponent: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "cart")
                .padding([.vertical], 10)
            
        })
        .frame(width: 60, height: 60)
        .background(Color.white)
        .cornerRadius(5)
        .padding()
        .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewMockViewModel()
        HomeView(viewModel: viewModel)
    }
}

final class HomeViewMockViewModel: HomeViewModelProtocol {
    @Published var isLoading: Bool = true
    
    @Published var gourmetCategories: [GourmetCategory] = []
    
    @Published var gourmetList: [GourmetList] = []
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            self?.gourmetCategories = [
                GourmetCategory(id: "1", name: "Popular"),
                GourmetCategory(id: "2", name: "Appetizer"),
                GourmetCategory(id: "3", name: "Main Course"),
                GourmetCategory(id: "4", name: "Dessert"),
                GourmetCategory(id: "5", name: "Beverages"),
            ]
            
            self?.gourmetList = [
                GourmetList(categoryID: "popular", items: [
                    GourmetItem(
                        id: "6121282188",
                        price: 1.5,
                        displayPrice: 1,
                        isDiscount: true,
                        discountPercent: 50,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                    GourmetItem(
                        id: "6121282181",
                        price: 1.5,
                        displayPrice: 1.5,
                        isDiscount: false,
                        discountPercent: 0,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                ]),
                GourmetList(categoryID: "appetizer", items: [
                    GourmetItem(
                        id: "6121282188",
                        price: 1.5,
                        displayPrice: 1,
                        isDiscount: true,
                        discountPercent: 50,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                    GourmetItem(
                        id: "6121282181",
                        price: 1.5,
                        displayPrice: 1.5,
                        isDiscount: false,
                        discountPercent: 0,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                ]),
                GourmetList(categoryID: "main_course", items: [
                    GourmetItem(
                        id: "6121282188",
                        price: 1.5,
                        displayPrice: 1,
                        isDiscount: true,
                        discountPercent: 50,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "Sizzling sausages made from szechuan peppercorn and sweet pepper, served in a roll",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                    GourmetItem(
                        id: "6121282181",
                        price: 1.5,
                        displayPrice: 1.5,
                        isDiscount: false,
                        discountPercent: 0,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                ]),
                GourmetList(categoryID: "dessert", items: [
                    GourmetItem(
                        id: "6121282188",
                        price: 1.5,
                        displayPrice: 1,
                        isDiscount: true,
                        discountPercent: 50,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                    GourmetItem(
                        id: "6121282181",
                        price: 1.5,
                        displayPrice: 1.5,
                        isDiscount: false,
                        discountPercent: 0,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                ]),
                GourmetList(categoryID: "beverages", items: [
                    GourmetItem(
                        id: "6121282188",
                        price: 1.5,
                        displayPrice: 1,
                        isDiscount: true,
                        discountPercent: 50,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                    GourmetItem(
                        id: "6121282181",
                        price: 1.5,
                        displayPrice: 1.5,
                        isDiscount: false,
                        discountPercent: 0,
                        imageURL: "https://picsum.photos/id/0/5616/3744",
                        name: "Nectarine and beetroot salad",
                        itemDescription: "A crisp salad featuring fresh nectarine and beetroot",
                        tags: [
                            "white_cabbage",
                            "lettuce",
                            "tomato",
                            "nectarine",
                            "beetroot"
                        ]),
                ]),
            ]
            
            self?.isLoading = false
        }
    }
}
