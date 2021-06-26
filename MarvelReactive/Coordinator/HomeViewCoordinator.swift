//
//  MainViewCoordinator.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 25/06/2021.
//

import RxSwift
import UIKit

final class MainViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {}
}
