//
//  Item34.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 9/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item34 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case2()
    }

    private func case1() {
        // Automatically dispose
        Observable.of("Any value emitted!")
            .subscribe(onNext: { item in print("next:", item) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func case2() {

        // Manually dispose
        let subscription =  Observable.of("Any value emitted!")
            .subscribe(onNext: { item in print("next:", item) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )

        Thread.sleep(forTimeInterval: 3.0)
        subscription.dispose()
    }

    func wrongNumberEmisor() -> Observable<Int> {
        return Observable.create { observer in
            observer.on(.next(1))
            observer.on(.next(2))
            observer.on(.next(3))
            return Disposables.create()
        }
    }
}
