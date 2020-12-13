//
//  Extensions.swift
//
//
//  Created by Krzysztof Kostrzewa on 05.12.20.
//

import Foundation
import Publish

extension Array where Element == UInt {
    @inlinable func contains(_ element: Element?) -> Bool {
        guard let element = element else { return false }
        return contains(element)
    }
}

extension PublishingContext where Site == JustABunchOfGrapes {
    var wines: [Wine] {
        sections
            .first { $0.id == .wines }!
            .items
            .compactMap(\.metadata.wine)
    }

    func winesItems(withIds: [UInt] = []) throws -> [Item<Site>] {
        sections
            .first { $0.id == .wines }!
            .items
            .filter { withIds.isEmpty || withIds.contains($0.metadata.wine!.id) }
            .sorted { $0.metadata.wine!.rank < $1.metadata.wine!.rank }
    }

    func comparisonItems() throws -> [Item<Site>] {
        sections
            .first { $0.id == .comparisons }!
            .items
    }
}

extension Theme where Site == JustABunchOfGrapes {
    static var wineTheme: Self {
        Theme(
            htmlFactory: WineThemeHTMLFactory(),
            resourcePaths: [
                "Resources/WineTheme/PTSans/PTSans-Regular.ttf",
                "Resources/WineTheme/PTSans/PTSans-Italic.ttf",
                "Resources/WineTheme/PTSans/PTSans-Bold.ttf",
                "Resources/WineTheme/PTSans/PTSans-BoldItalic.ttf",
            ]
        )
    }
}

extension Date {
    static var nowFormatted: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short

        return df.string(from: Date())
    }

    var formatted: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short

        return df.string(from: self)
    }
}
