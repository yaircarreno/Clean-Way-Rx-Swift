//
//  Item7.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item7 {

    let disposeBag = DisposeBag()
    let network: Network
    let cache: Cache

    init(network: Network, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    public func itemExample(apikey: String) {
        case3(apikey: apikey)
    }

    private func case1(apikey: String) {

        network.getToken(apikey)
            .subscribe(onNext: { token in
                if (token.isValid) {
                    self.cache.storeToken(token)
                        .subscribe(onNext: { saved in
                            print("Token stored: \(saved)")
                        })
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
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

    private func case3(apikey: String) {

        let oneSubject = PublishSubject<String>()
        let twoSubject = PublishSubject<String>()

        oneSubject
            .subscribe{ print($0) }
            .disposed(by: disposeBag)

        twoSubject
            .subscribe(onNext: { item in
                oneSubject.on(.next(item))
            })
            .disposed(by: disposeBag)

        twoSubject.on(.next("A"))
        twoSubject.on(.next("B"))
        twoSubject.on(.next("C"))
    }

    private func case4(apikey: String) {

        Observable.of("A", "B", "C")
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
}
