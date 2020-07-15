//
//  Item28.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 29/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item28 {

    struct SampleError: Swift.Error {}

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
            .concatMap { token in self.cache.storeTokenWithError(token) }
            .concatMap { saved in self.network.getUser(username) }
            .subscribe(onNext: { user in print("next:", user) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeTokenWithError(token) }
            .concatMap { saved in self.network.getUser(username) }
            .catchError({ error in Observable.just(User()) })
            .subscribe(onNext: { user in print("next:", user) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case3(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeTokenWithError(token) }
            .concatMap { saved in self.network.getUser(username) }
            .catchError({ error in Observable.empty()
                .do(onCompleted: { print(error)  }) })
            .subscribe(onNext: { user in print("next:", user) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case4(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeTokenWithError(token) }
            .concatMap { saved in self.network.getUser(username) }
            .retry(2)
            .catchError({ error in Observable.empty()
                .do(onCompleted: { print(error)  }) })
            .subscribe(onNext: { user in print("next:", user) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case5(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeTokenWithError(token) }
            .concatMap { saved in self.network.getUser(username) }
            .retryWhen{ errors in errors
                .do(onNext: { ignored in print("retrying...") })
                .delay(.seconds(2), scheduler: MainScheduler.instance)
                .take(4)
                .concat(Observable.error(SampleError()))}
            .catchError({ error in Observable.empty()
                .do(onCompleted: { print(error)  }) })
            .subscribe(onNext: { user in print("next:", user) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }
}
