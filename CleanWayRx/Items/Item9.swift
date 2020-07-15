//
//  Item9.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item9 {

    let disposeBag = DisposeBag()
    let network: Network
    let cache: Cache

    init(network: Network, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    public func itemExample(apikey: String) {
        case2(apikey: apikey)
    }

    private func case1(apikey: String) {

        var currentToken = Token(value: "abc-token", isValid: false)

        network.getToken(apikey)
            .subscribe(onNext: { token in
                currentToken = token
            })
            .disposed(by: disposeBag)

        if (currentToken.isValid) {
            cache.storeToken(currentToken)
                .subscribe(onNext: { saved in
                    print("Token stored: \(saved)")
                })
                .disposed(by: disposeBag)
        }
    }

    private func case2(apikey: String) {

        network.getToken(apikey)
            .filter { token in token.isValid }
            .concatMap { token in self.cache.storeToken(token) }
            .subscribe(onNext: { saved in
                print("Token stored: \(saved)")
            })
            .disposed(by: disposeBag)
    }
}
