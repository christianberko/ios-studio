import Foundation
import Testing
@testable import OverloadKit

@Test
func kitVersionIsSemverShaped() {
    #expect(OverloadKit.version == "0.2.0")
}

@Test
func massConvertsKilogramsToPounds() {
    let mass = Mass(kilograms: 100)
    #expect(abs(mass.pounds - 220.462_262_18) < 0.000_1)
}

@Test
func massConvertsPoundsToKilograms() {
    let mass = Mass(pounds: 220.462_262_18)
    #expect(abs(mass.kilograms - 100) < 0.000_1)
}

@Test
func massFormatsFixedKilograms() {
    #expect(Mass(kilograms: 100).formatted(unit: .kilograms, fractionDigits: 1) == "100.0 kg")
}

@Test
func massIsComparable() {
    #expect(Mass(kilograms: 40) < Mass(kilograms: 50))
}

@Test
func inMemoryKeyValueStoreRoundTripsCodableValues() throws {
    struct Prefs: Codable, Equatable {
        var displayName: String
        var reps: Int
    }

    let store = InMemoryKeyValueStore()
    let prefs = Prefs(displayName: "Squat", reps: 5)
    try store.set(prefs, forKey: "prefs")
    #expect(try store.value(forKey: "prefs", as: Prefs.self) == prefs)

    store.removeValue(forKey: "prefs")
    #expect(try store.value(forKey: "prefs", as: Prefs.self) == nil)
}

@Test
func layoutSpacingScaleIsStable() {
    #expect(LayoutSpacing.sm == 8)
    #expect(LayoutSpacing.md == 16)
}
