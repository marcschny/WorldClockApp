import SwiftUI

@main
struct WorldClockAppApp: App {
    var body: some Scene {
        WindowGroup {
            WorldClockView(viewModel: WorldClockViewModel())
        }
    }
}
