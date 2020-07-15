//
//  Item29.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 3/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item29 {

    let serialScheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case4()
    }

    private func case1() {

        let sourceObservable = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API with userId = \(id)")}
            .do(onNext: { result in print(result) })
            .take(1)

        let subscriptionA = sourceObservable
            .subscribe(onNext: { element in
                // A Observing code
            })

        let subscriptionB = sourceObservable
            .subscribe(onNext: { element in
                // B Observing code
            })

        let subscriptionC = sourceObservable
            .subscribe(onNext: { element in
                // C Observing code
            })

        // To avoid immediately dispose of the
        // emission and to see the share effect
        Thread.sleep(forTimeInterval: 5.0)
        subscriptionA.dispose()
        subscriptionB.dispose()
        subscriptionC.dispose()
    }

    private func case2() {

        let sourceObservable = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API with userId = \(id)")}
            .do(onNext: { result in print(result) })
            .take(1)
            .share()

        let subscriptionA = sourceObservable
            .subscribe(onNext: { element in
                // A Observing code
            })

        let subscriptionB = sourceObservable
            .subscribe(onNext: { element in
                // B Observing code
            })

        let subscriptionC = sourceObservable
            .subscribe(onNext: { element in
                // C Observing code
            })

        Thread.sleep(forTimeInterval: 5.0)
        subscriptionA.dispose()
        subscriptionB.dispose()
        subscriptionC.dispose()
    }

    private func case3() {

        let sourceObservable = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API with userId = \(id)")}
            .do(onNext: { result in print(result) })
            .take(1)
            .publish()

        sourceObservable
            .subscribe(onNext: { element in
                // A Observing code
            }).disposed(by: disposeBag)

        sourceObservable
            .subscribe(onNext: { element in
                // B Observing code
            }).disposed(by: disposeBag)

        sourceObservable
            .subscribe(onNext: { element in
                // C Observing code
            }).disposed(by: disposeBag)

        //Apply Connect
        sourceObservable.connect()
    }

    private func case4() {

        let observableA = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API A with userId = \(id)")}
            .take(1)


        let observableB = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API B with userId = \(id)")}
            .take(1)

        let observableC = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .flatMap { id -> Observable<String> in
                return Observable.just("Request to API C with userId = \(id)")}
            .take(1)

        Observable.merge(observableA, observableB, observableC)
            .subscribe(onNext: { result in
                print(result)
            })
            .disposed(by: disposeBag)

    }
}
