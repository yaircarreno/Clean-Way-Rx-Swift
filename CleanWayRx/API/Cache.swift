//
//  Cache.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 18/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Cache {

    struct SampleError: Swift.Error {}
    
    public func storeToken(_ token: Token) -> Observable<Bool> {
        return Observable.just(true)
    }

    public func storeTokenWithError(_ token: Token) -> Observable<Bool> {
        return Observable.error(SampleError())
    }
}
