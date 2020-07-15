//
//  Item23.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 8/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item23 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case1()
    }

    private func case1() {

        let uppercase = Observable.from(["A","B","C","D"])
        let lowercase = Observable.from(["a","b","c","d"])

        uppercase
            .flatMapLatest{ upperLetter in lowercase
                .map{ lowerLetter in upperLetter + lowerLetter} }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    private func case2() {
        
        let uppercase = Observable.from(["A","B","C","D"])
        let lowercase = Observable.from(["a","b","c","d"])

        Observable.combineLatest(uppercase, lowercase){
            upperLetter, lowerLetter  in upperLetter + lowerLetter
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
}
