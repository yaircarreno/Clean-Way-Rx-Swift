//
//  Item12.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 1/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item12 {

    let disposeBag = DisposeBag()

    public func itemExample() {
        case1()
    }

    private func case1() {

        Observable.from(itemsWithoutNulls())
            .map{ value in value!.uppercased() }
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func case2() {

        Observable.from(items())
            .filter { item in item != nil}
            .map{ value in value!.uppercased() }
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }

    private func items() -> [String?] {

        let optionalElements: [String?] = ["h", "e", nil, "l", "o"]
        return optionalElements
    }

    private func itemsFiltered() -> [String?] {

        let optionalElements: [String?] = ["h", "e", nil, "l", "o"]
        let filteredElements = optionalElements.filter({ $0 != nil })
        return filteredElements
    }

    private func itemsWithoutNulls() -> [String?] {

        let optionalElements: [String?] = ["h", "e", "l", "l", "o"]
        return optionalElements
    }
}
