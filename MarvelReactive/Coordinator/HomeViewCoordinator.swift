//
//  MainViewCoordinator.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 25/06/2021.
//

import RxSwift
import UIKit

final class HomeViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    private let disposeBag = DisposeBag()
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let vc = HomeViewController(viewModel: viewModel)
        router.pushViewController(vc, animated: true)
        
        viewModel.didSelectCharacter.drive(onNext: { [unowned self] character in
            self.showDetails(character: character)
        }).disposed(by: disposeBag)
    }
    
    func showDetails(character: MarvelCharacter?) {
        guard let character = character else { return }
        let detailsVC = CharacterDetailsViewController(character: character)
        router.pushViewController(detailsVC, animated: true)
    }
}
