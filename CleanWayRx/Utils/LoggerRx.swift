//
//  LoggerRx.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 1/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

private func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name == "" {
            return "Anonymous Thread"
        }
        return name
    } else {
        return "Unknown Thread"
    }
}

extension ObservableType {
    func logObservable() -> RxSwift.Observable<Self.Element> {
        return self.do(onNext: { element in
            let threadName = getThreadName()
            print("\(element) in Observable received on \(threadName)")
        })
    }

    func logObserver() -> Disposable {
        return self.subscribe(onNext: { element in
            let threadName = getThreadName()
            print("\(element) in Observer received on \(threadName)")
        })
    }
}
