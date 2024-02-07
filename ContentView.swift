import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                
                var input = InputComponent(label: "FirstInput")
                    .add()
                var A = ORGate(label: "A")
                    .add()
                    .connect(to: input)
                var B = ANDGate(label: "B")
                    .connect(to: A)
                    .add()
                var offInput = InputComponent(label: "OffInput")
                    .initialValue(false)
                    .connect(to: B, asInput: true)
                    .add()
                var output = OutputComponent(label: "FirstOutput")
                    .add()
                    .connect(to: B)
                
                ReasonEngine.shared.orderNodes()
                ReasonEngine.shared.printInOrder()
                
                ReasonEngine.shared.compute()
                ReasonEngine.shared.printInOrder()
                                
            } label: {
                Text("Hit me")
            }
        }
    }
}
