//
//  Item16.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 1/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Item16 {

    let disposeBag = DisposeBag()
    let network: Network
    let cache: Cache

    init(network: Network, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    public func itemExample(username: String) {

        case1(username: username)
    }

    private func case1(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .concatMap { saved in self.network.getUser(username) }
            .subscribe(onNext: { user in
                if (!user.name.isEmpty && !user.posts.isEmpty) {
                    for post in user.posts {
                        for comment in post.comments {
                            print("Date: \(comment.date) Comment: \(comment.text)")
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }

    private func case2(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .concatMap { saved in self.network.getUser(username) }
            .filter { user in !user.name.isEmpty && !user.posts.isEmpty }
            .map { user in user.posts }
            .flatMap { posts in Observable.from(posts)}
            .subscribe(onNext: { post in
                for comment in post.comments {
                    print("Date: \(comment.date) Comment: \(comment.text)")
                }
            })
            .disposed(by: disposeBag)
    }

    private func case3(username: String) {

        network.getToken("api-key")
            .concatMap { token in self.cache.storeToken(token) }
            .concatMap { saved in self.network.getUser(username) }
            .filter { user in !user.name.isEmpty && !user.posts.isEmpty }
            .map { user in user.posts }
            .flatMap { posts in Observable.from(posts).map{ post in post.comments}}
            .flatMap { comments in Observable.from(comments) }
            .subscribe(onNext: { comment in
                print("Date: \(comment.date) Comment: \(comment.text)")
            })
            .disposed(by: disposeBag)
    }
}
