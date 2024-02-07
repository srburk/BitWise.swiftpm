import SwiftUI

@main
struct MyApp: App {
    
    @ObservedObject var editorContext = EditorContext()
    @ObservedObject var reasonEngine = ReasonEngine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(editorContext)
                .environmentObject(reasonEngine)
        }
    }
}
