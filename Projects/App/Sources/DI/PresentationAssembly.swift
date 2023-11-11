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
    
    public func assemble(container: Container) {
        // ExampleTab1
        container.register(Tab1ViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return Tab1ViewModel(exampleUseCase: useCase)
        }
        .inObjectScope(.container)
        
        container.register(Tab1ViewController.self) { resolver in
            let viewModel = resolver.resolve(Tab1ViewModel.self)!
            return Tab1ViewController(viewModel: viewModel)
        }
        
        container.register(Tab1SubViewController.self) { resolver in
            let viewModel = resolver.resolve(Tab1ViewModel.self)!
            return Tab1SubViewController(viewModel: viewModel)
        }
        // ExampleTab2
        container.register(Tab2ViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return Tab2ViewModel(exampleUseCase: useCase)
        }
        container.register(Tab2ViewController.self) { resolver in
            let viewModel = resolver.resolve(Tab2ViewModel.self)!
            return Tab2ViewController(viewModel: viewModel)
        }
    }
    
}
