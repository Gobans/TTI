//
//  ExampleTab2ViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/09.
//  Copyright © 2023 gb. All rights reserved.
//

import Foundation
import Combine
import Domain

final public class ExampleTab2ViewModel: BaseViewModel {
    
    private let exampleUseCase: ExampleUseCase
    
    public init(exampleUseCase: ExampleUseCase, coordinator: CoordinatorProtocol) {
        self.exampleUseCase = exampleUseCase
        super.init(coordinator: coordinator)
    }
    
    public func moveToExampleSubView() {
        self.coordinator.push(.example2SubView)
    }
    
}
