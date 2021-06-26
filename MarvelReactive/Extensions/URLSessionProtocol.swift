//
//  URLSessionProtocol.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxSwift
import RxCocoa

protocol URLSessionProtocol {
    func data(from url: URL) -> Observable<Data>
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) -> Observable<Data> {
        let request = URLRequest(url: url)
        return self.rx.data(request: request)
    }
}
