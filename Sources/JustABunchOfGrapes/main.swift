import Foundation
import Publish
import Plot

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
        // Add any site-specific metadata that you want to use here.
        
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Just a Bunch of Grapes"
    var description = "A description of JustABunchOfGrapes"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try JustABunchOfGrapes()
    .publish(
        withTheme: .wineTheme,
        additionalSteps: []
    )
