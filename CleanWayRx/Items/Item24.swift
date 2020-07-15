//
//  Item24.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item24 {

    let disposeBag = DisposeBag()
    let network: Network

    var loggedIn = false

    init(network: Network) {
        self.network = network
    }

    public func itemExample(username: String) {
        case1(username: username)
    }

    private func case1(username: String) {

        network.getUser(username)
            .do(onNext: { user in self.logger(user) })
            .subscribe(onNext: { data in print("next:", data) })
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getUser(username)
            .do(onNext: { user in self.loggerWithSideEffect(user) })
            .subscribe(onNext: { user in
                if (!user.name.isEmpty && self.loggedIn){
                    // Do anything
                }
            })
            .disposed(by: disposeBag)
    }

    private func logger(_ object: Any) {
        print("Event operation in logs \(object)")
    }

    private func loggerWithSideEffect(_ object: Any) {
        print("Event operation in logs \(object)")
        loggedIn = true
    }
}
