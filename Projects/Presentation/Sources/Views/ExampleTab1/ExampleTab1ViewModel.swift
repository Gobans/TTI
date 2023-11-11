//
//  ExampleViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain

final public class ExampleTab1ViewModel: BaseViewModel {
    
    @Published private(set) var slip: SlipVO = SlipVO(id: 0, advice: "Empty")
    @Published private(set) var isLoading: Bool = false
    
    private let exampleUseCase: ExampleUseCase
    
    public init(exampleUseCase: ExampleUseCase, coordinator: CoordinatorProtocol) {
        self.exampleUseCase = exampleUseCase
        super.init(coordinator: coordinator)
    }
    
    func onChangeQuoteButtonClicked() {
        isLoading = true
        exampleUseCase.load()
            .receive(on: DispatchQueue.main)
            .sinkToResultWithErrorHandler({ slipVO in
                self.slip = slipVO
                self.isLoading = false
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
}
