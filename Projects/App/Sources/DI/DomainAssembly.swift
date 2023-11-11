//
//  DomainAssembly.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Domain
import Swinject

public struct DomainAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(ExampleUseCase.self) { resolver in
            let repository = resolver.resolve(ExampleRepository.self)!
            return DefaultExampleUseCase(repository: repository)
        }
        
    }
    
}
