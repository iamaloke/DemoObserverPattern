//
//  Extensions.swift
//  DemoObserverPattern
//
//  Created by Alok Kumar on 29/04/25.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
