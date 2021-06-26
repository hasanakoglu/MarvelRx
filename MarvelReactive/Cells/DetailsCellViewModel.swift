//
//  CharacterCellViewModel.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxSwift
import RxCocoa
import UIKit

final class CharacterCellViewModel {
    let name: Driver<String>
    let description: Driver<String>
    let image: Driver<UIImage?>
    
    init(characters: MarvelCharacter, imageProvider: ImageProviderProtocol = ImageProvider()) {
        name = characters.name
        image = imageProvider.loadImageFromUrl(url: URL(string: characters.thumbnail.full))
            .asDriver(onErrorJustReturn: nil)
    }
}
