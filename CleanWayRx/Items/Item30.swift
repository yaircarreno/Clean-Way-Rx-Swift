//
//  Item30.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 1/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item30 {

    let serialScheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()


    public func itemExample() {
        case1()
    }

    private func case1() {

        colorDataStream()
            .subscribeOn(serialScheduler)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })
            .disposed(by: disposeBag)
    }

    private func case2() {

        colorDataStream()
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })
            .disposed(by: disposeBag)
    }

    func colorDataStream() -> Observable<String> {
        return Observable.create { observer in
            observer.on(.next("Gray =>"))
            observer.on(.next("Blue =>"))
            observer.on(.next("Pink =>"))
            observer.on(.completed)
            return Disposables.create()
        }
    }

    private func loggerScheduler(_ element: Any, _ origin: String) {
        let threadName = self.getThreadName()
        print("\(element) \(origin) code executed on \(threadName)")
    }

    private func getThreadName() -> String {

        guard Thread.current.isMainThread else {
            let name = __dispatch_queue_get_label(nil)
            let currentQueueName = String(cString: name, encoding: .utf8) ?? Thread.current.name
            return currentQueueName!
        }
        return "Main Thread"
    }
}
