import SwiftUI

@main
struct MyApp: App {
    
    @ObservedObject var reasonEngine = ReasonEngine()
    @ObservedObject var editor = EditorContext()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(editor)
                .environmentObject(reasonEngine)
            
                // thread hanger code
                .task {
                        let approximateGranularity = Duration.milliseconds(10)
                        let threshold = Duration.milliseconds(50)

                        let clock = SuspendingClock()
                        var lastIteration = clock.now

                        while !Task.isCancelled {
                            try? await Task.sleep(for: approximateGranularity,
                                                  tolerance: approximateGranularity / 2,
                                                  clock: clock)

                            let now = clock.now

                            if now - lastIteration > threshold {
                                Log.general.error("Main thread hung for \((now - lastIteration).formatted(.units(width: .wide, fractionalPart: .show(length: 2)))).")
                            }

                            lastIteration = now
                        }
                    }
        }
        
    }
}
