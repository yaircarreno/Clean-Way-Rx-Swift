//
//  ViewController.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 18/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    private let network = Network()
    private let cache = Cache()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = Item3()
        item.itemExample()
    }
}
