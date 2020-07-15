//
//  Item3.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 23/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item3 {

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case3()
    }

    private func case1() {

        let first = Observable.of(10, 100, 1000)
        let second = Observable.of(20, 200, 2000)

        first
            .concat(second)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    private func case2() {

        let first = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
        let second = Observable.of(20, 200, 2000)

        let subscription = first
            .concat(second)
            .subscribe(onNext: { print($0) })

        Thread.sleep(forTimeInterval: 5.0)
        subscription.dispose()
    }

    private func case3() {

        let first = Observable<Int>.interval(.seconds(1), scheduler: scheduler).take(3)
        let second = Observable.of(20, 200, 2000)

        let subscription = first
            .concat(second)
            .subscribe(onNext: { print($0) })

        Thread.sleep(forTimeInterval: 5.0)
        subscription.dispose()
    }
}
