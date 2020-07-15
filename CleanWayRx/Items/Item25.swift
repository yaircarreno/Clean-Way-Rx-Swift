//
//  Item25.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 18/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item25 {

    let disposeBag = DisposeBag()
    let network: Network

    init(network: Network) {
        self.network = network
    }

    public func itemExample(username: String) {
        case1(username: username)
    }

    private func case1(username: String) {

        let token = network.getToken("api-key")

        token
            .map{ token in token.value }
            .subscribe(onNext: { value in
                self.setupRequest(value)
            })
            .disposed(by: disposeBag)
    }

    public func case2() {

        let token = network.getToken("api-key")

        token
            .subscribe(onNext: { token in
                self.setupRequest(token.value)
            })
            .disposed(by: disposeBag)
        
    }

    private func setupRequest(_ token: String) {
        print("\(token)")
    }
}
