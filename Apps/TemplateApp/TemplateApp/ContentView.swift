import OverloadKit
import SwiftUI

struct ContentView: View {
    private let sampleMass = Mass(kilograms: 60)

    var body: some View {
        VStack(alignment: .leading, spacing: LayoutSpacing.md) {
            Text("TemplateApp")
                .font(.largeTitle)
            Text("OverloadKit \(OverloadKit.version)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Sample mass \(sampleMass.formatted(unit: .kilograms))")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(LayoutSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onAppear {
            KitLog.info("TemplateApp launched with OverloadKit \(OverloadKit.version)")
        }
    }
}

#Preview {
    ContentView()
}
