//
//  TabBarCoordinator.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 gb. All rights reserved.
//


import Presentation
import UIKit

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get }
}

final class DefaultTabBarController: TabBarCoordinator {
    public struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
        weak var finishDelegate: CoordinatorFinishDelegate?
    }
    
    private let dependency: Dependency
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController = UITabBarController()
    var type: CoordinatorType = .tabbar
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    /// 탭바 flow 시작
    func start() {
        let pages: [TabBarPage] = TabBarPage.allCases
        let controllers: [UINavigationController] = pages.map({
            self.createTabNavigationController(of: $0)
        })
        self.configureTabbarController(with: controllers)
    }
    
    /// 각 탭바에 들어갈 네비게이션 컨트롤러 생성
    private func createTabNavigationController(of page: TabBarPage) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        self.startTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
    }
    
    /// 각 탭바에 들어갈 네비게이션 컨트롤러 설정
    private func configureTabbarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        self.tabBarController.selectedIndex = TabBarPage.tab1.pageOrderNumber()
        self.tabBarController.view.backgroundColor = .white
        self.tabBarController.tabBar.backgroundColor = .white
        self.tabBarController.tabBar.tintColor = .black
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }

    /// 각 탭바 아이템 설정
    private func configureTabBarItem(of page: TabBarPage) -> UITabBarItem {
        switch page {
        case .tab1:
            return UITabBarItem(title: page.rawValue, image: UIImage(systemName: "hexagon.fill"), tag: page.pageOrderNumber())
        case .tab2:
            return UITabBarItem(title: page.rawValue, image: UIImage(systemName: "pentagon.fill"), tag: page.pageOrderNumber())
        }
        
    }
    
    /// 각 탭 flow 시작
    private func startTabCoordinator(of page: TabBarPage, to tabNavigationController: UINavigationController) {
        switch page {
        case .tab1:
            let tab1ViewController = dependency.injector.resolve(Tab1ViewController.self)
            let tab1SubViewController = dependency.injector.resolve(Tab1SubViewController.self)
            let dependency = DefaultTab1Coordinator.Dependency.init(tab1ViewController: tab1ViewController,
                                                                    tab1SubViewController: tab1SubViewController,
                                                                    navigationController: tabNavigationController,
                                                                    finishDelegate: self)
            let tab1Coordinator = DefaultTab1Coordinator(dependency: dependency)
            tab1Coordinator.start()
            childCoordinators.append(tab1Coordinator)
            
        case .tab2:
            let tab2ViewController = dependency.injector.resolve(Tab2ViewController.self)
            let dependency = DefaultTab2Coordinator.Dependency.init(tab2ViewController: tab2ViewController,
                                                                        navigationController: tabNavigationController,
                                                                        finishDelegate: self)
            let tab2Coordinator = DefaultTab2Coordinator(dependency: dependency)
            tab2Coordinator.start()
            childCoordinators.append(tab2Coordinator)
        }
    }
}

/// 탭바 페이지 종류
enum TabBarPage: String, CaseIterable {
    case tab1, tab2
    
    init?(index: Int) {
        switch index {
        case 0: self = .tab1
        case 1: self = .tab2
        default: return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .tab1: return 0
        case .tab2: return 1
        }
    }
    
    func tabIconName() -> String {
        return self.rawValue
    }
}

/// 자식 코디네이터가 종료되었을 때 처리
extension DefaultTabBarController: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter{ $0.type != childCoordinator.type }
    }
}
