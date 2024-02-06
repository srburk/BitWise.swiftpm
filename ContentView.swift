import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                
                var A = ORGate(label: "A").add()
                var B = ORGate(label: "B")
                    .connect(to: A)
                    .add()
                
                ReasonEngine.shared.orderNodes()
                ReasonEngine.shared.printInOrder()
                                
            } label: {
                Text("Hit me")
            }
        }
    }
}
