//
//  HomeViewModel.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var gourmetCategories: [GourmetCategory] { get }
    var gourmetList: [GourmetList] { get }
    var isLoading: Bool { get }
    
    func fetchData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    @Published var gourmetCategories: [GourmetCategory] = []
    @Published var gourmetList: [GourmetList] = []
    @Published var isLoading: Bool = true
    
    private let repository: HomeRepositoryProtocol
    private var cancelables: Set<AnyCancellable> = []
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func fetchData() {
        repository
            .fetchHomeData()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self]
                completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.isLoading = false
                case .finished:
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] homeModel in
                
                self?.gourmetCategories = homeModel.categories
                self?.gourmetList = homeModel.list
            })
            .store(in: &cancelables)
    }
}
