//
//  CoordinatorFactory.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 25/06/2021.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeHomeViewCoordinator(router: Router) -> Coordinator
    func makeFavouritesCoordinator(router: Router) -> Coordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeHomeViewCoordinator(router: Router) -> Coordinator {
        HomeViewCoordinator(router: router)
    }
    
    func makeFavouritesCoordinator(router: Router) -> Coordinator {
        FavouritesCoordinator(router: router)
    }
}
