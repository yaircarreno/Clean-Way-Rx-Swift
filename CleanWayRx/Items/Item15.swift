//
//  Item15.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 23/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item15 {

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case3()
    }

    private func case1() {

        let source = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
        
        let subscriptionOne = source
            .map{ item in item * 3 }
            .filter{ item in item % 2 == 0 }
            .subscribe(onNext: { data in print("from observer one:", data) })

        let subscriptionTwo = source
            .map{ item in item * 3 }
            .filter{ item in item % 3 == 0 }
            .subscribe(onNext: { data in print("from observer two:", data) })

        Thread.sleep(forTimeInterval: 5.0)
        subscriptionOne.dispose()
        subscriptionTwo.dispose()
    }

    private func case2() {

        let source = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
            .map{ item in item * 3 }

        let subscriptionOne = source
            .filter{ item in item % 2 == 0 }
            .subscribe(onNext: { data in print("from observer one:", data) })

        let subscriptionTwo = source
            .filter{ item in item % 3 == 0 }
            .subscribe(onNext: { data in print("from observer two:", data) })

        Thread.sleep(forTimeInterval: 5.0)
        subscriptionOne.dispose()
        subscriptionTwo.dispose()
    }

    private func case3() {

        let source = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
            .debug("Observable")
            .map{ item in item * 3 }
            .share(replay: 1)

        let subscriptionOne = source
            .filter{ item in item % 2 == 0 }
            .subscribe(onNext: { data in print("from observer one:", data) })

        let subscriptionTwo = source
            .filter{ item in item % 3 == 0 }
            .subscribe(onNext: { data in print("from observer two:", data) })

        Thread.sleep(forTimeInterval: 5.0)
        subscriptionOne.dispose()
        subscriptionTwo.dispose()
    }
}
