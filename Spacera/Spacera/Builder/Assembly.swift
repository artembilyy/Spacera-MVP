//
//  Assembly.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIPageViewController
    func createRocketModule(index: Int?, router: RouterProtocol) -> UIViewController?
    func createLaunchModule(rocketID: String?, router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIPageViewController {
        let networkService = NetworkService()
        let view = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        view.router = router
        return view
    }
    func createRocketModule(index: Int?, router: RouterProtocol) -> UIViewController? {
        let networkService = NetworkService()
        let view = RocketViewController()
        let presenter = RocketPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        view.index = index
        return view
    }
    func createLaunchModule(rocketID: String?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = LaunchViewController()
        let presenter = LaunchPresenter(view: view, networkService: networkService, router: router, rocketID: rocketID)
        view.presenter = presenter
        return view
    }
}

