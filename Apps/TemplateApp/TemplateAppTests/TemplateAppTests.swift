import OverloadKit
import Testing

@Test
func appDependsOnOverloadKit() {
    #expect(OverloadKit.version == "0.2.0")
}

@Test
func appCanFormatSharedMassValues() {
    #expect(Mass(kilograms: 60).formatted(unit: .pounds, fractionDigits: 0) == "132 lb")
}
