//
//  HomeViewModel.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxCocoa
import RxSwift

class HomeViewModel {
    private let scheduler: SchedulerType
    private let disposeBag = DisposeBag()
    
    private let characterDataItemsRelay = BehaviorRelay<[MarvelCharacter]>(value: [])
    let tableViewData: Observable<[HomeViewSection]>
    
    let marvelCharacters: Driver<[MarvelCharacter]>
    let selectCharacter: AnyObserver<MarvelCharacter?>
    let didSelectCharacter: Driver<MarvelCharacter?>
    private let selectCharacterSubject = PublishSubject<MarvelCharacter?>()
    
    init(client: APIClient = APIClient(),
         scheduler: SchedulerType = MainScheduler.instance) {
        self.scheduler = scheduler
        
        let headerSection = Observable<[HomeViewSection]>.just([.headerSection(items: [.header(title: "Marvel Universe", subtitle: "Dive into the world of Marvel by discovering some of the many fantastic characters in the Marvel Universe!")])])
        
        let detailSection = characterDataItemsRelay
            .map { items -> [HomeViewSection] in
                let dashboardItems = items.map { HomeViewItem.details(model: $0) }
                let detailSection = HomeViewSection.detailSection(items: dashboardItems)
                return [detailSection]
            }
        
        client.fetchCharacters()
            .observe(on: scheduler)
            .map { character -> [MarvelCharacter] in
                guard let character = character else { return [] }
                return character.data.characters
            }
            .bind(to: characterDataItemsRelay)
            .disposed(by: disposeBag)
        
        marvelCharacters = characterDataItemsRelay.asDriver(onErrorJustReturn: [])
        didSelectCharacter = selectCharacterSubject.asDriver(onErrorJustReturn: nil)
        selectCharacter = selectCharacterSubject.asObserver()
        
        tableViewData = Observable.combineLatest(headerSection, detailSection)
            .map { $0 + $1 }
            .distinctUntilChanged()
    }
}
