//
//  Observer.swift
//  DemoObserverPattern
//
//  Created by Alok Kumar on 29/04/25.
//

import Foundation

protocol Observer: AnyObject {
    var id: Int { get set }
    var message: String? { get set }
    
    func update(data: String)
}
