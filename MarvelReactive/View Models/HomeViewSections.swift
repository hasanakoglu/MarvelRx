//
//  HomeViewSections.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxDataSources

enum HomeViewSection: Equatable {
    case headerSection(items: [HomeViewItem])
    case detailSection(items: [HomeViewItem])
}

enum HomeViewItem: Equatable {
    case header(title: String?, subtitle: String?)
    case details(model: MarvelCharacter)
}

extension HomeViewSection: SectionModelType {
    typealias Item = HomeViewItem
    
    var items: [HomeViewItem] {
        switch self {
        
        case .headerSection(let items):
            return items
        case .detailSection(let items):
            return items
        }
    }
    
    init(original: HomeViewSection, items: [HomeViewItem]) {
        switch original {
        
        case .headerSection:
            self = .headerSection(items: items)
        case .detailSection:
            self = .detailSection(items: items)
        }
    }
}

extension HomeViewItem {
    static func == (lhs: HomeViewItem, rhs: HomeViewItem) -> Bool {
        return true
    }
}
