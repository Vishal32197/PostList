//
//  UserListViewModel.swift
//  UserListDemo
//
//  Created by Bishal Ram on 26/04/24.
//

import Foundation
import RxSwift
import RxRelay

protocol UserListViewModelProtocol {
    var dataSource: BehaviorRelay<[Post]> { get }
    var currentPage: Int { get set }
    func fetchPosts(page: Int)
}

final class UserListViewModel: UserListViewModelProtocol {
    // MARK: // Private Properties
    private let networkService: NetworkServiceProtocol
    private var posts: [Post] = []
    
    var dataSource = RxRelay.BehaviorRelay<[Post]>(value: [])
    var currentPage: Int = 0
    
    // MARK: // Initialisation
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: // Network Call Methods
    func fetchPosts(page: Int) {
        let params = ["page": String(page),
                      "limit": String(20)]
        
        networkService.request(route: .fetchData, method: .get, params: params) { [weak self] response, error  in
            
            guard let self = self else { return }
            if let error = error {
                return
            } else {
                if let response = response {
                    self.posts.append(contentsOf: response)
                    self.dataSource.accept(self.posts)
                }
            }
        }
    }
}
