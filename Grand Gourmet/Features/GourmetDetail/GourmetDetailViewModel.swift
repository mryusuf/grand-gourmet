//
//  GourmetDetailViewModel.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import Foundation
import Combine

protocol GourmetDetailViewModelProtocol: ObservableObject {
    var gourmet: GourmetDetail? { get }
    var isLoading: Bool { get }
    
    func fetchData()
}

final class GourmetDetailViewModel: GourmetDetailViewModelProtocol {
    
    // TODO: to improve, breakdown GourmetDetail for views
    @Published var gourmet: GourmetDetail? = nil
    @Published var isLoading: Bool = true
    
    private let repository: GourmetDetailRepositoryProtocol
    private var cancelables: Set<AnyCancellable> = []
    
    init(repository: GourmetDetailRepositoryProtocol = GourmetDetailRepository()) {
        self.repository = repository
    }
    
    func fetchData() {
        repository
            .fetchGourmetDetail()
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
            }, receiveValue: { [weak self] gourmetDetailModel in
                self?.gourmet = gourmetDetailModel
            })
            .store(in: &cancelables)
    }
}
