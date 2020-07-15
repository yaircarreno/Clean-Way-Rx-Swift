//
//  Item14.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 22/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item14 {

    struct SampleError: Swift.Error {}

    let disposeBag = DisposeBag()
    let network: Network

    init(network: Network) {
        self.network = network
    }

    public func itemExample(apikey: String) {
        case2(apikey: apikey)
    }

    private func case1(apikey: String) {

        network.getToken(apikey)
            .subscribe(onNext: { token in
                if (token.isValid) {
                    // First condition
                } else {
                    // Second condition
                }
            })
            .disposed(by: disposeBag)
    }

    private func case2(apikey: String) {

        let valid = network.getToken(apikey)
            .flatMap{ token in self.verifyToken(token).materialize()}

        valid
            .map{ $0.element }
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: { data in print("token is valid:", data) })
            .disposed(by: disposeBag)

        valid
            .map { $0.error?.localizedDescription }
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: { data in print("token is not valid:", data) })
            .disposed(by: disposeBag)
    }

    private func case3(apikey: String) {
        
        let valid = network.getToken(apikey)
            .flatMap{ token in self.verifyToken(token).materialize()}

        valid
            .compactMap { $0.element }
            .subscribe(onNext: { data in print("token is valid:", data) })
            .disposed(by: disposeBag)

        valid
            .compactMap { $0.error?.localizedDescription }
            .subscribe(onNext: { data in print("token is not valid:", data) })
            .disposed(by: disposeBag)
    }

    private func verifyToken(_ token: Token) -> Observable<Token> {
        if token.isValid {
            return .just((token))
        } else {
            return .error(SampleError())
        }
    }
}
