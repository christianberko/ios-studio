import OverloadKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("TemplateApp")
                .font(.largeTitle)
            Text("OverloadKit \(OverloadKit.version)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
