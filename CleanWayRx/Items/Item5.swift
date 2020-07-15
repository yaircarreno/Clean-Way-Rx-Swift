//
//  Item5.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 19/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item5 {

    let disposeBag = DisposeBag()
    let network: Network
    let cache: Cache

    init(network: Network, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    public func itemExample(username: String) {

        case5(username: username)
    }

    private func case1(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token)
                .concatMap { saved in self.network.getUser(username) }
        }
        .subscribe(onNext: { user in print(user) })
        .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .concatMap { saved in self.network.getUser(username) }
            .subscribe(onNext: { user in print(user) })
            .disposed(by: disposeBag)
    }

    private func case3(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token)
                .concatMap { saved in self.network.getUser(username, token) }
        }
        .subscribe(onNext: { user in print(user) })
        .disposed(by: disposeBag)
    }
    
    private func case4(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token).map{saved in (token, saved)} }
            .concatMap { pair in self.network.getUser(username, pair.0) }
            .subscribe(onNext: { user in print(user) })
            .disposed(by: disposeBag)
    }

    private func case5(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .ignoreElements()
            .andThen(self.network.getUser(username))
            .subscribe(onNext: { user in print(user) })
            .disposed(by: disposeBag)
    }
}
