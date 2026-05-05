import SwiftUI

@main
struct cribcreww_appApp: App {
    @AppStorage("cc-theme") private var themeRaw: String = "light"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeRaw == "dark" ? .dark : .light)
        }
    }
}
