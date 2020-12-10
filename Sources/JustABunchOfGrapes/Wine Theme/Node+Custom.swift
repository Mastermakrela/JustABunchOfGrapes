//
//  Node+Custom.swift
//
//
//  Created by Krzysztof Kostrzewa on 05.12.20.
//

import Foundation
import Plot
import Publish

// MARK: - Universal

extension Node where Context == HTML.BodyContext {
    static func content(_ nodes: Node...) -> Node {
        .div(.class("content"), .group(nodes))
    }

    static func header(for context: PublishingContext<JustABunchOfGrapes>, selectedSection: JustABunchOfGrapes.SectionID?) -> Node {
        .header(
            .content(
                .a(
                    .href("/"),
                    .div(
                        .class("site-name"),
                        .logo(),
                        .text(context.site.name)
                    )
                ),
                .nav(
                    .ul(.forEach(JustABunchOfGrapes.SectionID.allCases) { section in
                        .li(.a(
                            .class(section == selectedSection ? "selected" : ""),
                            .href(context.sections[section].path),
                            .text(context.sections[section].title)
                        ))
                    })
                )
            )
        )
    }

    static func footer<T: Website>(for _: T) -> Node {
        .footer(
            .logo(),
            .p(
                .text("Last generated on \(Date.nowFormatted)")
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            )),
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            )
        )
    }

    static func logo() -> Node {
        .div(
            .class("logo"),
            .img(.src(Path("Grapes.svg")))
        )
    }
}

// MARK: - Wine Page

extension Node where Context == HTML.BodyContext {
    static func wineImage(path: Path?) -> Node {
        .div(.class("wine-image"), .img(.src(path ?? .defaultWineImage)))
    }

    static func wineInfo(wine: Wine) -> Node {
        .table(
            .class("wine-dossier"),
            .caption(.text("Dossier")),
            .tr(.th(.text("Vintage")), .td(.text("\(wine.vintage)"))),
            .tr(.th(text("Grapes")), .td(.text(wine.grapes.joined(separator: ", ")))),
            .tr(.th(text("Region")), .td(.text(wine.region))),
            .tr(.th(text("Color")), .td(.text("\(wine.color)"))),
            .tr(.th(text("Winery")), .td(.text(wine.winery))),
            .tr(.th(text("Alcohol Content")), .td(.text("\(wine.alcoholContent)")))
        )
    }

    static func wineHeader(wineItem: Item<JustABunchOfGrapes>) -> Node {
        .group(
            .h1(.class("wine-title"), .text(wineItem.title)),
            .wineImage(path: wineItem.imagePath),
            .wineInfo(wine: wineItem.metadata.wine!)
        )
    }
}

extension Node where Context == HTML.ListContext {
    static func stat(label: String, value: String) -> Node {
        .li(
            .span(.class("label"), .text(label)),
            .span(.class("value"), .text(value))
        )
    }
}

// MARK: - Comparison Page

extension Node where Context == HTML.BodyContext {
    static func comparisonHeader(comparisonItem: Item<JustABunchOfGrapes>) -> Node {
        .div(
            .class("comparison-header"),
            .p(.h1(.text(comparisonItem.title))),
            .p(.text(comparisonItem.date.formatted))
        )
    }

    private static func comparee(wineItem: Item<JustABunchOfGrapes>) -> Node {
        .a(
            .href(wineItem.path),
            .div(
                .class("comparee"),
                .img(.src(wineItem.imagePath ?? .defaultWineImage)),
                .p(.text(wineItem.metadata.wine!.name)),
                .wineInfo(wine: wineItem.metadata.wine!)
            )
        )
    }

    static func comparees(wineItems: [Item<JustABunchOfGrapes>]) -> Node {
        .div(
            .class("comparees"),
            .forEach(wineItems, comparee)
        )
    }
}

// MARK: - Wine Section

extension Node where Context == HTML.BodyContext {
    static func winesList(wineItems: [Item<JustABunchOfGrapes>]) -> Node {
        .ul(
            .class("wines-list"),
            .forEach(wineItems) { item in
                .li(
                    .div(
                        .class("wine-item"),
                        .wineImage(path: item.imagePath),
                        .div(
                            .h1(.a(
                                .href(item.path),
                                .text(item.title)
                            )),
                            .p(.text(item.description))
                        )

                    ))
            }
        )
    }
}

// MARK: - Comparison Section

extension Node where Context == HTML.BodyContext {
    static func comparisonsList(comparisonItems: [Item<JustABunchOfGrapes>], in context: PublishingContext<JustABunchOfGrapes>) throws -> Node {
        .ul(
            .class("comparisons-list"),
            try .forEach(comparisonItems) { item in
                let wines = try context.winesItems(withIds: item.metadata.comparison!.wineIds)

                return .li(
                    .div(
                        .class("comparison-item"),
                        .img(
                            .class("comparee-1"),
                            .src(wines.first!.imagePath!)
                        ),
                        .div(.class("content"),
                             .h2(.a(
                                 .href(item.path),
                                 .text(item.title)
                             )),
                             .p(.text(item.description))),
                        .img(
                            .class("comparee-2"),
                            .src(wines.last!.imagePath!)
                        )

                    ))
            }
        )
    }
}

// MARK: - Ranking Section

extension Node where Context == HTML.BodyContext {
    static func ranking(wineItems: [Item<JustABunchOfGrapes>]) -> Node {
        .ul(
            .class("ranking"),
            .forEach(wineItems) { wineItem in
                .li(
                    .div(
                        .class("ranking-item"),
                        .h1(.a(
                            .href(wineItem.path),
                            .text(wineItem.title)
                        )),
                        .p(.text(wineItem.description)),
                        .img(.src(wineItem.imagePath ?? .defaultWineImage))
                    )
                )
            }
        )
    }
}
