//
//  UserListView+ViewModel.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

extension UserListView {
    final class ViewModel: ObservableObject {
        
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
            getUsersList.invoke(requestValues: .init())
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                } receiveValue: { [weak self] userDTOs in
                    self?.userItems = userDTOs.map { UserItem(from: $0) }
                }
                .store(in: &cancellables)
        }
    }
}
