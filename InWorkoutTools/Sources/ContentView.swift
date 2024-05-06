import SwiftUI
import SomeFramework

public struct ContentView: View {
    let framework = SomeFrameworkClass()
    public init() {}

    public var body: some View {
        VStack() {
            Text(framework.tellMeSomething())
                .padding(.top, 40)
                .padding(.bottom, 20)
                .font(.system(size: 24, weight: .bold))
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
