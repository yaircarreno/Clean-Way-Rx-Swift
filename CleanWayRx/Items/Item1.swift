//
//  Item1.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 26/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item1 {

    struct SampleError: Swift.Error {}

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()

    public func itemExample() {
        case11()
    }

    private func case1() {

        Observable.of(["h", "e"], ["l", "l", "o"])
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func case2() {

        Observable.just(["h", "e", "l", "l", "o"])
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func case3() {

        Observable.from(["h", "e", "l", "l", "o"])
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func case4() {

        Observable.range(start: 1, count: 5)
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func case5() {

        Observable.deferred {
            return Observable.just(["h", "e", "l", "l", "o"])
        }
        .subscribe(onNext: { element in print(element) })
        .disposed(by: disposeBag)
    }

    private func case6() {

        Observable<String>.empty()
            .subscribe { event in print(event) }
            .disposed(by: disposeBag)
    }

    private func case7() {

        Observable<String>.never()
            .subscribe { event in print(event) }
            .disposed(by: disposeBag)
    }

    private func case8() {

        Observable<String>.error(SampleError())
            .subscribe { event in print(event) }
            .disposed(by: disposeBag)
    }

    private func case9() {

        let subscription = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
            .subscribe { event in print(event) }

        Thread.sleep(forTimeInterval: 5.0)
        subscription.dispose()
    }

    private func case10() {

        let subscription = Observable<Int>.timer(.seconds(2), scheduler: scheduler)
            .subscribe { event in print(event) }

        Thread.sleep(forTimeInterval: 5)
        subscription.dispose()
    }

    private func case11() {

        taskWrapped(task: self.imperativeTask())
            .subscribe(onNext: { data in print("next:", data) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    private func taskWrapped(task: Any?) -> Observable<Any> {

        return Observable.create { observer in

            guard let data = task else {
                observer.onError(SampleError())
                return Disposables.create {}
            }

            observer.onNext(data)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    private func imperativeTask() -> Any? {

        let data = "any data"
        print("Do any imperative task or process")

        return data
    }
}
