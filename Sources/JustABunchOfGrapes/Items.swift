//
//  Items.swift
//
//
//  Created by Krzysztof Kostrzewa on 03.12.20.
//

import Foundation
import Publish

enum ItemTypes {
    case wine, comparison
}

struct Wine: WebsiteItemMetadata {
    enum WineColor: String, Codable {
        case red, white, rose
    }

    let id: UInt

    let name: String
    let vintage: Int
    let grapes: [String]
    let region: String
    let color: WineColor
    let winery: String
    let alcoholContent: Double

    let rank: Double
}

struct Comparison: WebsiteItemMetadata {
    let id: UInt
    let date: Date
    let wineIds: [UInt]
}
