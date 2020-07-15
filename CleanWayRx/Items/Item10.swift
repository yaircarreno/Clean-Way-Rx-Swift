//
//  Item10.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 25/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item10 {
    
    let disposeBag = DisposeBag()
    
    public func itemExample() {
        case2()
    }
    
    private func case1() {
        
        Observable.just("data")
            .do(onCompleted: { self.runProcess() })
            .map{ item in "transformed " + item }
            .subscribe(onNext: { item in print("item:", item) })
            .disposed(by: disposeBag)
        
    }

    private func case2() {

        Observable.just("data")
            .do(onCompleted: { self.runBlock() })
            .map{ item in "transformed " + item }
            .subscribe(onNext: { item in print("item:", item) })
            .disposed(by: disposeBag)

    }
    
    private func runProcess() {
        print("Running any process")
    }

    private func runBlock() -> Completable {
        return Completable.create { completable in

            self.runProcess()

            completable(.completed)
            return Disposables.create {}
        }
    }
}
