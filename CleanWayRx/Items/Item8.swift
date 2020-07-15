//
//  Item8.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 18/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift


struct Item8 {

    let disposeBag = DisposeBag()

    public func itemExample(first : Int, second: Int) {

        Observable.just((first,second))
            .map{ pair in max(pair.0, pair.1) }
            .subscribe(onNext: { data in print("next:", data) },
                       onError: { error in print("error:", error) },
                       onCompleted: { print("completed") } )
            .disposed(by: disposeBag)
    }

    // Imperactive way
    private func maximumImperactiveWay(first : Int, second: Int) -> Int {
        return (first >= second) ? first : second;
    }

    // Most complex way
    private func maximumComplexWay(first : Int, second: Int) -> Observable<Int> {
        return Observable.just((first >= second) ? first : second);
    }

    // Super complex way
    private func maximumSuperComplexWay(left : Observable<Int>,
                                        right: Observable<Int>) -> Observable<Int> {
        return Observable.zip(left, right){ first, second in (first >= second) ? first : second }
    }
}
