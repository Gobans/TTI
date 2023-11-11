//
//  AppCoordinator.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Presentation
import Domain

public class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published public var path: NavigationPath
    @Published public var sheet: AppScene?
    private let initialScene: AppScene
    var injector: Injector?
    
    public init(_ initialScene: AppScene) {
        self.initialScene = initialScene
        self.path = NavigationPath()
    }
    
    public func buildInitialScene() -> some View {
        return buildScene(scene: initialScene)
    }
    
    public func push(_ scene: AppScene) {
        path.append(scene)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func present(sheet: AppScene) {
        self.sheet = sheet
    }
    
    public func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    public func buildScene(scene: AppScene) -> some View {
        switch scene {
        case .example1Scene:
            injector?.resolve(ExampleTab1View.self)
        case .example2Scene:
            injector?.resolve(ExampleTab2View.self)
        case .example2SubView:
            injector?.resolve(Example2SubView.self)
        case .rootTabScene:
            injector?.resolve(RootTabView.self)
        }
    }
    
    @ViewBuilder
    public func buildSheet(scene: AppScene) -> some View {
        NavigationStack {
            buildScene(scene: scene)
        }
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}
