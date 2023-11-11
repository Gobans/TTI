import SwiftUI
import Data
import Presentation
import Domain
import Swinject

@main
struct LitoApp: App {
    private let injector: Injector
    @ObservedObject private var coordinator: Coordinator
    
    init() {
        injector = DependencyInjector(container: Container())
        coordinator = Coordinator(.rootTabScene)
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(
                            coordinator: coordinator
                           )])
        coordinator.injector = injector
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.buildInitialScene()
                    .navigationDestination(for: AppScene.self) { scene in
                        coordinator.buildScene(scene: scene)
                    }
                    .sheet(item: $coordinator.sheet) { scene in
                        coordinator.buildScene(scene: scene)
                    }
            }
        }
    }
}
