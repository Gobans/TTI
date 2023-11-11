//
//  Tab2Coordinator.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 gb. All rights reserved.
//

import UIKit

public protocol Tab2Coordinator: Coordinator {
    func showExample2TabFlow()
}

public class DefaultTab2Coordinator: Tab2Coordinator {
    public struct Dependency {
        let tab2ViewController: Tab2ViewController
        let navigationController: UINavigationController
        weak var finishDelegate: CoordinatorFinishDelegate?
        
        public init(tab2ViewController: Tab2ViewController, navigationController: UINavigationController, finishDelegate: CoordinatorFinishDelegate? = nil) {
            self.tab2ViewController = tab2ViewController
            self.navigationController = navigationController
            self.finishDelegate = finishDelegate
        }
    }
    
    let dependency: Dependency
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var type: CoordinatorType = .tab2
    public var finishDelegate: CoordinatorFinishDelegate?
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
        self.finishDelegate = dependency.finishDelegate
        dependency.tab2ViewController.viewModel.tab2Coordinator = self
    }
    
    public func start() {
        setNavigationBar()
        showExample2TabFlow()
    }
    
    func setNavigationBar() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func showExample2TabFlow() {
        navigationController.pushViewController(dependency.tab2ViewController, animated: true)
    }
}
