import Testing
@testable import OverloadKit

@Test
func kitVersionIsSemverShaped() {
    #expect(OverloadKit.version == "0.1.0")
}

@Test
func massConvertsKilogramsToPounds() {
    let mass = Mass(kilograms: 100)
    #expect(abs(mass.pounds - 220.462_262_18) < 0.000_1)
}
