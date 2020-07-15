//
//  Item13.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 22/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item13 {

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
            .subscribe(onNext: { token in
                if (token.isValid) {
                    print(token)
                }
            })
            .disposed(by: disposeBag)
    }

    private func case2(apikey: String) {

        network.getToken(apikey)
            .filter{ token in token.isValid}
            .subscribe(onNext: { token in
                print(token)
            } )
            .disposed(by: disposeBag)
    }

    private func case3(apikey: String) {

        network.getToken(apikey)
            .subscribe(onNext: { token in
                if (token.isValid) {
                    print(token)
                } else {
                    //Token is not valid
                }
            })
            .disposed(by: disposeBag)
    }
}
