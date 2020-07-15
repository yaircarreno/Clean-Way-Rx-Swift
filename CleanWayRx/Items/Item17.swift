//
//  Item17.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 22/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item17 {

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
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { token in
                print(token);
            })
            .disposed(by: disposeBag)
    }
}
