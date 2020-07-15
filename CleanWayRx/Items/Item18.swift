//
//  Item18.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item18 {

    let disposeBag = DisposeBag()
    let network: Network

    init(network: Network) {
        self.network = network
    }

    public func itemExample(username: String) {
        case1(username: username)
    }

    private func case1(username: String) {

        network.getUser(username)
            .filter{ user in !user.name.isEmpty }
            .subscribe(onNext: { data in print("next:", data) },
                       onError: { error in print("error:", error) },
                       onCompleted: { () in print("completed") } )
            .disposed(by: disposeBag)
    }
}
