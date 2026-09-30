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
