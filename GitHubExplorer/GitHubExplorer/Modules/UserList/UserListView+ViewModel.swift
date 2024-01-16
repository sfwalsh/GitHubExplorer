//
//  UserListView+ViewModel.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

enum PaginationState {
    case idle
    case loading
    case error(error: Error)
}

extension UserListView {
    final class ViewModel: ObservableObject {
        
        private var nextSince: Int?
        
        @Published var paginationState: PaginationState = .idle
        @Published var userItems: [UserItem] = []
        private var cancellables: Set<AnyCancellable> = []
        
        private let getUsersList: GetUsersList
        
        init(
            userItems: [UserItem],
            getUsersList: GetUsersList
        ) {
            self.userItems = userItems
            self.getUsersList = getUsersList
        }
        
        func fetchData() {
            guard case .idle = paginationState else {
                return
            }
            
            paginationState = .loading
            getUsersList.invoke(requestValues: .init(since: nextSince))
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        self.paginationState = .idle
                    case .failure(let error):
                        self.paginationState = .error(error: error)
                    }
                } receiveValue: { [weak self] userDTOs in
                    guard let self = self else { return }
                    self.userItems.append(contentsOf: userDTOs.map { UserItem(from: $0) })
                    
                    // get the next since value from the last user item
                    if let lastUserItem = userDTOs.last {
                        self.nextSince = lastUserItem.id
                    }
                }
                .store(in: &cancellables)
        }
    }
}
