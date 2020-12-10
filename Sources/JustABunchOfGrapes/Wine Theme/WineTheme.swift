//
//  WineTheme.swift
//
//
//  Created by Krzysztof Kostrzewa on 02/12/2020.
//

import Plot
import Publish

struct WineThemeHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<JustABunchOfGrapes>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .content(
                    .div(.text("latest wines")),
                    .div(.text("latest comparisons")),
                    .div(
                        .class("description"),
                        index.content.body.node
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<JustABunchOfGrapes>, context: PublishingContext<JustABunchOfGrapes>) throws -> HTML {
        var body: Node<HTML.BodyContext> = .empty

        switch section.id {
        case .wines:
            body = .winesList(wineItems: section.items)

        case .comparisons:
            body = try .comparisonsList(comparisonItems: section.items, in: context)

        case .ranking:
            let wines = try context.winesItems()

            body = .ranking(wineItems: wines)

        case .about:
            break
        }

        return HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .content(
                    section.body.node,
                    body
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<JustABunchOfGrapes>, context: PublishingContext<JustABunchOfGrapes>) throws -> HTML {
        var body: Node<HTML.BodyContext> = .empty

        if item.metadata.wine != nil {
            body = .article(.class("wine"),
                            .wineHeader(wineItem: item),
                            .div(
                                .class("description"),
                                .contentBody(item.body)
                            ))

        } else if let comparison = item.metadata.comparison {
            let wines = try context.winesItems(withIds: comparison.wineIds)

            body = .article(.class("comparison"),
                            .comparisonHeader(comparisonItem: item),
                            .div(
                                .class("description"),
                                .contentBody(item.body)
                            ),
                            .comparees(wineItems: wines))

        } else {
            fatalError("bruh, what are we doin here?")
        }

        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .header(for: context, selectedSection: item.sectionID),
                .content(body),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<JustABunchOfGrapes>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .h1(.text("PAGE")),
                .content(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for _: TagListPage, context _: PublishingContext<JustABunchOfGrapes>) throws -> HTML? { nil }
    func makeTagDetailsHTML(for _: TagDetailsPage, context _: PublishingContext<JustABunchOfGrapes>) throws -> HTML? { nil }
}
