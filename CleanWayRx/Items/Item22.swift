//
//  Item22.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 8/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item22 {

    let disposeBag = DisposeBag()
    let network: Network
    let cache: Cache

    init(network: Network, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    public func itemExample(username: String) {

        case1(username: username)
    }

    private func case1(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .ignoreElements()
            .andThen(self.network.getUser(username))
            .subscribe(onNext: { user in print(user) })
            .disposed(by: disposeBag)
    }
}
