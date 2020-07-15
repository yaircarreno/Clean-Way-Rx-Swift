//
//  Item26.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 20/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item26 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case3()
    }

    private func case1() {
        let calculate = Observable.just(doAnyOperation())
    }

    private func case2() {

        let calculate = Observable.just(doAnyOperation())

        calculate
            .subscribe { print($0) }
            .disposed(by: disposeBag);
    }

    private func case3() {

        let calculate = Observable.deferred {
            return .just(self.doAnyOperation())
        }
    }

    private func case4() {

        let calculate = Observable.deferred {
            return .just(self.doAnyOperation())
        }

        calculate
            .subscribe { print($0) }
            .disposed(by: disposeBag);
    }

    private func doAnyOperation() {
        print("Do it!")
    }
}
