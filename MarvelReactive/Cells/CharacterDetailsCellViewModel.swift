//
//  CharacterDetailsCellViewModel.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxCocoa
import RxSwift

class CharacterDetailsCellViewModel {
    let image: Driver<UIImage?>
    let name: Driver<String>
    let description: Driver<String>
        
    init(characters: MarvelCharacter, imageProvider: ImageProviderProtocol = ImageProvider()) {
        image = imageProvider.loadImageFromUrl(url: URL(string: characters.thumbnail.full))
            .asDriver(onErrorJustReturn: nil)
        name = .just(characters.name)
        description = .just(characters.description)
    }
}
