//
//  Util.swift
//  Pods-RXSwiftDemo
//
//  Created by HaviLee on 2019/6/10.
//

import Foundation
import RxSwift

let start = Date()

fileprivate func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name == ""{
            return "anonymous thread"
        } else {
            return name
        }
    } else {
        return "unknown thread"
    }
}

fileprivate func secondsElapsed() -> String {
    return String(format: "%02i", Int(Date().timeIntervalSince(start).rounded()))
}

extension ObservableType {

    func dump() -> RxSwift.Observable<Self.E> {
        return self.do(onNext: { element in
            let threadName = getThreadName()
            print("\(secondsElapsed())s | [D] \(element) received on \(threadName)")
        })
    }

    func dumpingSubscription() -> Disposable {
        return self.subscribe(onNext: { element in
            let threadName = getThreadName()
            print("\(secondsElapsed())s | [S] \(element) received on \(threadName)")
        })
    }

}
