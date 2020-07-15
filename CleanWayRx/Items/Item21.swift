//
//  Item21.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 25/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item21 {

    struct SampleError: Swift.Error {}

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case1()
    }

    private func case1() {

        operationRx()
            .map{ item in item * 3 }
            .subscribe(onNext: { item in print("item:", item) },
                       onCompleted: { self.lastStep() } )
            .disposed(by: disposeBag)
    }

    private func case2() {

        let subscription =  operationRxChanged()
            .map{ item in item * 3 }
            .subscribe(onNext: { item in print("item:", item) },
                       onCompleted: { self.lastStep() } )

        Thread.sleep(forTimeInterval: 5.0)
        subscription.dispose()
    }

    private func case3() {

        numberEmitter()
            .map{ item in item * 3 }
            .subscribe(onNext: { item in print("item:", item) },
                       onCompleted: { self.lastStep() })
            .disposed(by: disposeBag)
    }

    private func case4() {

        wrongNumberEmitter()
            .map{ item in item * 3 }
            .subscribe(onNext: { item in print("item:", item) },
                       onCompleted: { self.lastStep() })
            .disposed(by: disposeBag)
    }

    private func operationRx() -> Observable<Int> {
        return Observable.from([1,2,3,4,5])
    }

    private func operationRxChanged() -> Observable<Int> {
        return Observable<Int>.interval(.seconds(1), scheduler: scheduler)
    }

    func numberEmitter() -> Observable<Int> {
        return Observable.create { observer in
            observer.on(.next(1))
            observer.on(.next(2))
            observer.on(.next(3))
            observer.on(.completed)
            return Disposables.create()
        }
    }

    func wrongNumberEmitter() -> Observable<Int> {
        return Observable.create { observer in
            observer.on(.next(1))
            observer.on(.next(2))
            observer.on(.completed)
            observer.on(.next(3))
            return Disposables.create()
        }
    }


    private func lastStep() {
        print("Do any critical thing, for instance, release resources.")
    }
}
