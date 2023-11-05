//
//  File.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import UIKit

@propertyWrapper
public struct InstantiateView<T: UIView> {

    public var wrappedValue: T

    public init(type: T.Type) {
        self.wrappedValue = .init(frame: .zero)
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

