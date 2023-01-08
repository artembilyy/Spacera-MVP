//
//  RocketPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation

protocol RocketViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol RocketViewPresenterProtocol: AnyObject {
    var rockets: [Rocket]? { get set }
    init(view: RocketViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getRockets()
    func showLaunches(rocketID: String?)
}

class RocketPresenter: RocketViewPresenterProtocol {

    var rockets: [Rocket]?
    var router: RouterProtocol?
    weak var view: RocketViewProtocol?
    
    let networkService: NetworkServiceProtocol!
    required init(view: RocketViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getRockets()
    }
    
    func getRockets() {
        networkService.getRockets { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let rockets):
                    self.rockets = rockets
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func showLaunches(rocketID: String?) {
        router?.lauchesViewController(rocketID: rocketID)
    }
}
