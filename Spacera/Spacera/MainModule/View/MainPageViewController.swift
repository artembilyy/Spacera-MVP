//
//  MainPageViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import UIKit

final class MainPageViewController: UIPageViewController {
    // MARK: - Controllers
    var presenter: MainViewPresenterProtocol!
    var router: RouterProtocol!
    private var controllers: [UIViewController] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
    }
    private func delegate() {
        dataSource = self
        delegate = self
    }
    private func configureRocketModule() {
        for index in 0...3 {
            if let rocketViewController = router?.rocketViewController(index: index) {
                controllers.append(rocketViewController)
            }
        }
        setViewControllers([controllers[0]], direction: .forward, animated: false)
    }
}

extension MainPageViewController: MainViewProtocol {
    func success() {
        configureRocketModule()
    }
    
    func failure(error: Error) {
        debugPrint(error.localizedDescription)
    }
}
extension MainPageViewController: UIPageViewControllerDataSource {
    // MARK: - Swipe
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = controllers.firstIndex(of: viewController) else { return nil }
        if indexOfCurrentPageViewController < 1 {
            return nil
        } else {
            return controllers[indexOfCurrentPageViewController - 1]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndexOfPageViewController = controllers.firstIndex(of: viewController) else { return nil }
        if currentIndexOfPageViewController == controllers.count - 1 {
            return nil
        } else {
            return controllers[currentIndexOfPageViewController + 1]
        }
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {
    // MARK: - Dots count
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

