//
//  Item11.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 22/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item11 {

    let disposeBag = DisposeBag()
    let network: Network

    init(network: Network) {
        self.network = network
    }

    public func itemExample(apikey: String) {
        case1(apikey: apikey)
    }

    private func case1(apikey: String) {

        network.getToken(apikey)
            .map { token in token.value }
            .subscribe(onNext: { value in
                print("Token's value: ", value);
            })
            .disposed(by: disposeBag)
    }

    private func case2(apikey: String) {

        network.getToken(apikey)
        .subscribe(onNext: { token in
            print("Token's value: ", token.value);
            print("Token's state: ", token.isValid);
        })
        .disposed(by: disposeBag)
    }
}
