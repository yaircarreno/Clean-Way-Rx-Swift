//
//  Item6.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 21/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item6 {

    struct SampleError: Swift.Error {}

    let disposeBag = DisposeBag()
    let network: Network

    var loggedIn = false;
    let anyState = false;

    init(network: Network) {
        self.network = network
    }

    public func itemExample(username: String) {
        case1(username: username)
    }

    private func case1(username: String) {

        // Use verifyUser(user, true) to simulate error.

        network.getUser(username)
            .do(onNext: { usr in self.loggedIn = true })
            .flatMap{ user in self.verifyUser(user) }
            .subscribe(onNext: {
                print($0)
                print(self.loggedIn)
            }, onError: { error in
                print("error:", error)
                print(self.loggedIn)
            }, onCompleted: { () in
                print("completed")
            })
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        // Use verifyUser(user, true) to simulate error.

        network.getUser(username)
            .flatMap{ user in self.verifyUser(user) }
            .subscribe(onNext: {
                self.loggedIn = true
                print($0)
                print(self.loggedIn)
            }, onError: { error in
                print("error:", error)
                print(self.loggedIn)
            }, onCompleted: { () in
                print("completed")
            })
            .disposed(by: disposeBag)
    }

    private func case3(username: String) {

        network.getUser(username)
            .filter{ user in !user.name.isEmpty && self.anyState }
            .subscribe(onNext: {
                self.loggedIn = true
                print($0)
            }, onError: { error in
                print("error:", error)
            }, onCompleted: { () in
                print("completed")
            })
            .disposed(by: disposeBag)
    }

    private func case4(username: String, state: Bool) {

        network.getUser(username)
            .filter{ user in !user.name.isEmpty && state }
            .subscribe(onNext: {
                self.loggedIn = true
                print($0)
            }, onError: { error in
                print("error:", error)
            }, onCompleted: { () in
                print("completed")
            })
            .disposed(by: disposeBag)
    }

    private func verifyUser(_ user: User, _ isSimulatedError: Bool = false) -> Observable<User> {
        return Observable.create { observer in

            if isSimulatedError {
                observer.on(.error(SampleError()))
            }

            observer.on(.next(user))
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
