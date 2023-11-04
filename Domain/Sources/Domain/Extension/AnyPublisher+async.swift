//
//  AnyPublisher+async.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/4/23.
//

import Combine

extension AnyPublisher {
    struct Subscriber {
        fileprivate let send: (Output) -> Void
        fileprivate let complete: (Subscribers.Completion<Failure>) -> Void

        func send(_ value: Output) {
            self.send(value)
        }
        func send(completion: Subscribers.Completion<Failure>) {
            self.complete(completion)
        }
    }

    init(_ closure: (Subscriber) -> AnyCancellable) {
        let subject = PassthroughSubject<Output, Failure>()

        let subscriber = Subscriber(
            send: subject.send,
            complete: subject.send(completion:)
        )
        let cancel = closure(subscriber)

        self = subject
            .handleEvents(receiveCancel: cancel.cancel)
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher {
    init(taskPriority: TaskPriority? = nil, asyncFunc: @escaping () async throws -> Output) {
        self.init { subscriber in
            let task = Task(priority: taskPriority) {
                do {
                    subscriber.send(try await asyncFunc())
                    subscriber.send(completion: .finished)
                } catch {
                    subscriber.send(completion: .failure(error as! Failure))
                }
            }
            return AnyCancellable {
                task.cancel()
            }
        }
    }
}
