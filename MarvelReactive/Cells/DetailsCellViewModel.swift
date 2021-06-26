//
//  CharacterCellViewModel.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxSwift
import RxCocoa
import UIKit

final class DetailsCellViewModel {
    let name: Driver<String>
    let image: Driver<UIImage?>
    
    init(characters: MarvelCharacter, imageProvider: ImageProviderProtocol = ImageProvider()) {
        name = .just(characters.name)
        image = imageProvider.loadImageFromUrl(url: URL(string: characters.thumbnail.full))
            .asDriver(onErrorJustReturn: nil)
    }
}
