//
//  Item.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
