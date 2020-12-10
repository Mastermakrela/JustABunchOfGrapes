import Foundation
import MinifyCSSPublishPlugin
import Plot
import Publish
import SassPublishPlugin

// This type acts as the configuration for your website.
struct JustABunchOfGrapes: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case wines
        case comparisons
        case ranking
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        let wine: Wine?
        let comparison: Comparison?
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Just a Bunch of Grapes"
    var description = """
        A description of JustABunchOfGrapes
    """
    var language: Language { .english }
    var imagePath: Path? = nil
}

try JustABunchOfGrapes()
    .publish(using: [
        .optional(.copyResources()),
        .addMarkdownFiles(),
        .sortItems(by: \.date, order: .descending),
        .generateHTML(withTheme: .wineTheme, indentation: .none),
        .generateSiteMap(indentedBy: .none),
        .installPlugin(
            .compileSass(
                sassFilePath: "Resources/WineTheme/styles.scss",
                cssFilePath: "styles.css",
                compressed: true
            )
        ),
        .installPlugin(
            .compileSass(
                sassFilePath: "Resources/WineTheme/fonts.scss",
                cssFilePath: "fonts.css",
                compressed: true
            )
        ),
        .installPlugin(.minifyCSS()),
    ])
