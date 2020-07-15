//
//  Item27.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 20/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item27 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case2()
    }

    private func case1() {

        let source = queryToAPI()

        //Wait for ten seconds
        Thread.sleep(forTimeInterval: 10)
        source
            .flatMap{ result1 in self.validateDataFromAPI()
                .map{ result2 in [result1, result2]} }
            .subscribe(onNext: { messages in
                print(messages[0])
                print(messages[1])
            } )
            .disposed(by: disposeBag)
    }

    private func case2() {

        let source = queryToAPIWhitDefer()

        //Wait for ten seconds
        Thread.sleep(forTimeInterval: 10)
        source
            .flatMap{ result1 in self.validateDataFromAPI()
                .map{ result2 in [result1, result2]} }
            .subscribe(onNext: { messages in
                print(messages[0])
                print(messages[1])
            } )
            .disposed(by: disposeBag)
    }

    private func queryToAPI() -> Observable<String> {
        return Observable.of("Query API at => " + getCurrentTime())
    }

    private func queryToAPIWhitDefer() -> Observable<String> {
        return Observable.deferred {
            return Observable.of("Query API at => " + self.getCurrentTime())
        }
    }

    private func validateDataFromAPI() -> Observable<String> {
        return Observable.of("Validate data from API at => " + getCurrentTime())
    }

    private func getCurrentTime() -> String {

        let date = Date()
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        return "\(minute)m: \(second)s"
    }
}
