//
//  Item16.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 22/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item19 {

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case1()
    }

    private func case1() {

        let source = Observable.of(10, 100, 1000)

        source
            .reduce(1, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    private func case2() {

        let source = Observable<Int>.interval(.seconds(1), scheduler: scheduler)

        source
            .reduce(1, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    private func case3() {

        let source = Observable<Int>.interval(.seconds(1), scheduler: scheduler).take(3)

        source
            .reduce(1, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}
