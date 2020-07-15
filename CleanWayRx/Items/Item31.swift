//
//  Item31.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 2/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item31 {

    let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    let serialScheduler = SerialDispatchQueueScheduler(qos: .default)
    let disposeBag = DisposeBag()


    public func itemExample() {
        case4()
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
            .observeOn(globalScheduler)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribeOn(serialScheduler)
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })
            .disposed(by: disposeBag)
    }

    private func case3() {

        colorDataStream()
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribeOn(serialScheduler)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribeOn(globalScheduler)
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })
            .disposed(by: disposeBag)
    }

    private func case4() {

        colorDataStream()
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .observeOn(globalScheduler)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .observeOn(serialScheduler)
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })
            .disposed(by: disposeBag)
    }

    func colorDataStream() -> Observable<String> {
        return Observable.create { observer in
            observer.on(.next("Gray =>"))
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
