//
//  Rouer.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import UIKit

protocol MainRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: MainRouter {
    func initialViewController()
    func rocketViewController(index: Int?) -> UIViewController?
    func lauchesViewController(rocketID: String?)
    func settingViewController()
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let pageViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [pageViewController]
        }
    }
    func rocketViewController(index: Int?) -> UIViewController? {
        let rocketViewController = assemblyBuilder?.createRocketModule(index: index, router: self)
        return rocketViewController!
    }
    func lauchesViewController(rocketID: String?) {
        if let navigationController = navigationController {
            guard let launchViewController = assemblyBuilder?.createLaunchModule(rocketID: rocketID, router: self) else { return }
            navigationController.pushViewController(launchViewController, animated: true)
        }
    }
    
    func settingViewController() {
        
    }
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
