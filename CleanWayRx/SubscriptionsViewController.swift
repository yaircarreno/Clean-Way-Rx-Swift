//
//  SubscriptionsViewController.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 10/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import UIKit
import RxSwift

class SubscriptionsViewController: UIViewController {

    let scheduler = SerialDispatchQueueScheduler(qos: .default)
    var subscriptions = [Disposable]()

    override func viewDidLoad() {
        super.viewDidLoad()

        subscriptions.append(
            Observable<Int>
                .interval(.seconds(1), scheduler: scheduler)
                .subscribe { event in print(event) })

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        for subscription in subscriptions {
            subscription.dispose()
        }
    }
}
