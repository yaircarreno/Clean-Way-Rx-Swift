//
//  TakeSubscriptionsViewController.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 10/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import UIKit
import RxSwift

class TakeSubscriptionsViewController: UIViewController {

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    let cancel = PublishSubject<Bool>()

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable<Int>.interval(.seconds(1), scheduler: scheduler)
            .takeUntil(cancel)
            .subscribe { event in print(event) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancel.onNext(true)
        cancel.onCompleted()
    }
}
