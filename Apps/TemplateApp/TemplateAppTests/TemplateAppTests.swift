import OverloadKit
import Testing

@Test
func appDependsOnOverloadKit() {
    #expect(OverloadKit.version == "0.1.0")
}
