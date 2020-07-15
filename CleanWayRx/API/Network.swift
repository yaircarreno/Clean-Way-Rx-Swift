//
//  Network.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 18/06/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import Foundation
import RxSwift

struct Network {

    public func getToken(_ apikey: String) -> Observable<Token> {
        return .just(Token(value: "abc-token", isValid: true))
    }

    public func getUser(_ username: String) -> Observable<User> {
        let comments = [Comment(date: Date(), text: "This is a fake comment!"),
                        Comment(date: Date(), text: "This is another fake comment!")]
        let posts = [Post(title: "Post", text: "", comments: comments)]
        // To simulate an empty user
        //return Observable.just(User(name: "", email: "", posts: []))
        return Observable.just(User(name: "Yair Carreno", email: "yair@email", posts: posts))
    }

    public func getUser(_ username: String, _ token: Token) -> Observable<User> {
        return Observable.just(User(name: "Yair Carreno", email: "yair@email", posts: []))
    }

    public func getPosts(_ user: User) -> Observable<[Post]> {
        return Observable.just([Post(title: "Rx", text: "Clean Way Rx", comments: [])])
    }

    public func getComments(_ post: Post) -> Observable<[Comment]> {
        return Observable.just([Comment(date: Date(), text: "Good practices!")])
    }
}
