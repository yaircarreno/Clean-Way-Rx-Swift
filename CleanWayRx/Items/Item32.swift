//
//  Item32.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 2/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//
import Foundation
import RxSwift

class Item32 {

    let serialScheduler = SerialDispatchQueueScheduler(qos: .default)
    let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    let disposeBag = DisposeBag()


    public func itemExample() {
        case2()
    }

    private func case1() {

        let sourceOne = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .map{ number in "Source one: \(number) =>" }
            .take(3)

        let sourceTwo = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .map{ number in "Source two: \(number) =>" }
            .take(2)

        let subscription = Observable
            .concat(sourceOne,sourceTwo)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })

        Thread.sleep(forTimeInterval: 10.0)
        subscription.dispose()
    }

    private func case2() {

        let sourceShared = Observable<Int>
            .interval(.seconds(1), scheduler: serialScheduler)
            .share()

        let sourceOne = sourceShared
            .map{ number in "Source one: \(number) =>" }
            .take(3)

        let sourceTwo = sourceShared
            .map{ number in "Source two: \(number) =>" }
            .take(2)

        let subscription = Observable
            .concat(sourceOne,sourceTwo)
            .throttle(.seconds(2), latest: true, scheduler: globalScheduler)
            .do(onNext: { element in self.loggerScheduler(element, "Observable") })
            .subscribe(onNext: { element in
                self.loggerScheduler(element, "Observer")
            })

        Thread.sleep(forTimeInterval: 10.0)
        subscription.dispose()
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
