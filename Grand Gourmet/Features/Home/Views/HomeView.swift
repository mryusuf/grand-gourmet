//
//  HomeView.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingIndicator
            } else {
                content
            }
        }.onAppear {
            self.viewModel.fetchData()
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var content: some View {
        ZStack {
            
            Color.black.opacity(0.06)
            
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(
                            self.viewModel.gourmetCategories,
                            id: \.id
                        ) { category in
                            Button(category.name) {
    //                            scrollView.scrolrlTo(
                            }
                        }
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(self.viewModel.gourmetList, id: \.categoryID) { (list: GourmetList) in
                        
                        HomeGourmetViewComponent(list: list)
                    }
                }
            }
        
        }
    }
    
}
