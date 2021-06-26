//
//  MarvelAPI.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 25/06/2021.
//

import RxCocoa
import RxSwift

enum CharacterError: Error {
    case noData
    case jsonError
}

enum MarvelAPI {
    static let charactersURL = "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=ff3d4847092294acc724123682af904b&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified"
}

protocol APIClientProtocol {
    func fetchCharacters() -> Observable<CharacterResponseModel?>
}

class APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchCharacters() -> Observable<CharacterResponseModel?> {
        guard let url = URL(string: MarvelAPI.charactersURL) else { return Observable.just(nil) }
        return session.data(from: url).map { data -> CharacterResponseModel? in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            return try? jsonDecoder.decode(CharacterResponseModel.self, from: data)
        }
    }
}

