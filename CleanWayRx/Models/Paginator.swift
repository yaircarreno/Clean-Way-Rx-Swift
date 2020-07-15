//
//  Paginator.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 9/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Paginator {

    private let page: PublishSubject<Int>
    static let instance = Paginator()

    private init() {
        page = PublishSubject<Int>()
    }

    func getResults(query: String) -> Observable<String> {
        
        return getPage()
            .flatMap { numberPage -> Observable<String> in
                return Observable.just("page: \(numberPage) and query: \(query)")
        }
        .share()
    }

    func pushPage(numberPage: Int) {
        page.onNext(numberPage)
    }

    func complete() {
        page.onCompleted()
    }

    private func getPage() -> Observable<Int> {
        return page.asObserver()
    }
}
