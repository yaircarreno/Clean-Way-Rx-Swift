//
//  Item4.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item4 {

    let disposeBag = DisposeBag()
    let network: Network

    init(network: Network) {
        self.network = network
    }

    public func itemExample(username: String) {
        case2(username: username)
    }

    private func case1(username: String) {

        network.getUser(username)
            .flatMap{ user in !user.name.isEmpty ?  Observable.just(user): Observable.empty() }
            .subscribe(onNext: { data in print("next:", data) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getUser(username)
            .flatMap{ user in !user.name.isEmpty ?  Observable.just(user): Observable.never() }
            .subscribe(onNext: { data in print("next:", data) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }
}
