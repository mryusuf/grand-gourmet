//
//  Grand_GourmetApp.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 01/06/22.
//

import SwiftUI

@main
struct Grand_GourmetApp: App {
    
    let homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
        }
    }
}
