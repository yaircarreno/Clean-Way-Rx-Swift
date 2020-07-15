//
//  Counter.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 20/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation

class Counter {
    private (set) var value : Int32 = 0
    func increment () {
        OSAtomicIncrement32(&value)
    }
}
