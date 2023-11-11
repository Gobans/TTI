//
//  PresentationAssembly.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Swinject
import Domain
import Presentation

public struct PresentationAssembly: Assembly {
    
    let coordinator: Coordinator
    
    public func assemble(container: Container) {
        // ExampleTab1
        container.register(ExampleTab1ViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return ExampleTab1ViewModel(exampleUseCase: useCase, coordinator: coordinator)
        }
        container.register(ExampleTab1View.self) { resolver in
            let viewModel = resolver.resolve(ExampleTab1ViewModel.self)!
            return ExampleTab1View(viewModel: viewModel)
        }
        // ExampleTab2
        container.register(ExampleTab2ViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return ExampleTab2ViewModel(exampleUseCase: useCase, coordinator: coordinator)
        }
        container.register(ExampleTab2View.self) { resolver in
            let viewModel = resolver.resolve(ExampleTab2ViewModel.self)!
            return ExampleTab2View(viewModel: viewModel)
        }
        container.register(Example2SubView.self) { _ in
            return Example2SubView()
        }
        // RootTab
        container.register(RootTabView.self) { resolver in
            let tab1 = resolver.resolve(ExampleTab1View.self)!
            let tab2 = resolver.resolve(ExampleTab2View.self)!
            return RootTabView(tab1: tab1, tab2: tab2)
        }
    }
    
}
