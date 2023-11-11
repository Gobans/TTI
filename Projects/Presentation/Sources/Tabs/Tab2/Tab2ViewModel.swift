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

final public class Tab2ViewModel {
    
    private let exampleUseCase: ExampleUseCase
    public weak var tab2Coordinator: Tab2Coordinator?
    
    public var cancelBag = Set<AnyCancellable>()
    
    @Published var adviceQuote = SlipVO(id: 0, advice: "")
    public var loadingSubject = PassthroughSubject<Bool, Never>()
    
    public init(exampleUseCase: ExampleUseCase) {
        self.exampleUseCase = exampleUseCase
    }
    
    public func changeQuote() {
        self.exampleUseCase.load()
            .sinkToResult { result in
                switch result {
                case .failure:
                    break
                case .success(let quote):
                    self.adviceQuote = quote
                    self.loadingSubject.send(true)
                }
            }
            .store(in: &cancelBag)
    }
    
}
