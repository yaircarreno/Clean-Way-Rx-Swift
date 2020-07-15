//
//  Item20.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 27/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item20 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case2()
    }

    private func case1() {

        Observable.of("A", "B", "C")
            .asSingle()
            .subscribe(onSuccess: { data in print("next:", data) } )
            .disposed(by: disposeBag)
    }

    private func case2() {

        Observable.of("A", "B", "C")
            .take(1)
            .asSingle()
            .subscribe(onSuccess: { data in print("next:", data) } )
            .disposed(by: disposeBag)
    }
}
