//
//  Item2.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 26/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

class Item2 {

    struct SampleError: Swift.Error {}

    let disposeBag = DisposeBag()
    let network: Network
    var userGlobal: User

    init(network: Network) {
        self.network = network
        self.userGlobal = User(name: "", email: "", posts: [])
    }

    public func itemExample(username: String) {
        case3(username: username)
    }

    private func case1(username: String) {

        network.getUser(username)
            .flatMap({ user -> Observable<User> in
                self.userGlobal = User(name: user.name, email: user.email, posts: user.posts)
                return Observable.just(self.userGlobal)
            })
            .subscribe(onNext: { user in print("user:", self.userGlobal) })
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getUser(username)
            .subscribe(onNext: { user in
                self.userGlobal = user
                print("user:", self.userGlobal)
            })
            .disposed(by: disposeBag)
    }

    private func case3(username: String) {

        getGlobalUser()
            .subscribe(onNext: { user in print("user:", self.userGlobal) })
            .disposed(by: disposeBag)
    }

    private func getGlobalUser() -> Observable<User> {

        return Completable.create { completable in

            self.userGlobal = User(name: "", email: "", posts: [])
            self.userGlobal.name = "Name"

            guard !self.userGlobal.name.isEmpty else {
                completable(.error(SampleError()))
                return Disposables.create {}
            }

            completable(.completed)
            return Disposables.create {}
        }
        .andThen(Observable.just(self.userGlobal))
    }

    private func getGlobalUserBetter() -> Completable {

        return Completable.create { completable in

            let user = User(name: "Name", email: "", posts: [])

            guard !user.name.isEmpty else {
                completable(.error(SampleError()))
                return Disposables.create {}
            }

            completable(.completed)
            return Disposables.create {}
        }
    }
}
