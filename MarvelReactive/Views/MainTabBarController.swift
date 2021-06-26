//
//  MainTabBarController.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 25/06/2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    lazy var homeTab: UITabBarItem = {
        let defaultImage = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        return UITabBarItem(title: "Home", image: defaultImage, selectedImage: selectedImage)
    }()
    
    lazy var favouritesTab: UITabBarItem = {
        let defaultImage = UIImage(systemName: "star")
        let selectedImage = UIImage(systemName: "star.fill")
        return UITabBarItem(title: "Favourites", image: defaultImage, selectedImage: selectedImage)
    }()
    
    private(set) var coordinators: [Coordinator] = []
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(coordinatorFactory: CoordinatorFactoryProtocol = CoordinatorFactory()) {
        self.coordinatorFactory = coordinatorFactory
        super.init(nibName: nil, bundle: nil)
        setupTabs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupTabs() {
        let homeNav = UINavigationController()
        homeNav.tabBarItem = homeTab
        let homeViewCoordinator = coordinatorFactory.makeHomeViewCoordinator(router: homeNav)
        homeViewCoordinator.start()
        
        let favouritesNav = UINavigationController()
        favouritesNav.tabBarItem = favouritesTab
        let favouritesCoordinator = coordinatorFactory.makeFavouritesCoordinator(router: favouritesNav)
        favouritesCoordinator.start()
        
        viewControllers = [homeNav, favouritesNav]
        coordinators = [homeViewCoordinator, favouritesCoordinator]
    }
}
