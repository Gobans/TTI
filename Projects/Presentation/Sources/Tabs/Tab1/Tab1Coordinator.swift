//
//  Tab1Coordinator.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 gb. All rights reserved.
//

import UIKit

public protocol Tab1Coordinator: Coordinator {
    func showExample1TabFlow()
    func push(_ scene: Tab1Scenes)
    func pop()
}

public class DefaultTab1Coordinator: Tab1Coordinator {
    public struct Dependency {
        let tab1ViewController: Tab1ViewController
        let tab1SubViewController: Tab1SubViewController
        let navigationController: UINavigationController
        weak var finishDelegate: CoordinatorFinishDelegate?
        
        public init(tab1ViewController: Tab1ViewController, tab1SubViewController: Tab1SubViewController, navigationController: UINavigationController, finishDelegate: CoordinatorFinishDelegate? = nil) {
            self.tab1ViewController = tab1ViewController
            self.tab1SubViewController = tab1SubViewController
            self.navigationController = navigationController
            self.finishDelegate = finishDelegate
        }
    }
    
    let dependency: Dependency
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var type: CoordinatorType = .tab1
    public var finishDelegate: CoordinatorFinishDelegate?
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
        self.finishDelegate = dependency.finishDelegate
        dependency.tab1ViewController.viewModel.tab1Coordinator = self
    }
    
    public func start() {
        setNavigationBar()
        showExample1TabFlow()
    }
    
    func setNavigationBar() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func showExample1TabFlow() {
        navigationController.pushViewController(dependency.tab1ViewController, animated: true)
    }
    
    public func push(_ scene: Tab1Scenes) {
        switch scene {
        case .tab1View:
            navigationController.pushViewController(dependency.tab1ViewController, animated: true)
        case .tab1SubView:
            navigationController.pushViewController(dependency.tab1SubViewController, animated: true)
        }
    }
    
    public func pop() {
        navigationController.popViewController(animated: true)
    }
}
