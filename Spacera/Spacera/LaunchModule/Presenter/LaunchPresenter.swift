//
//  LaunchPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation

protocol LaunchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol LaunchViewPresenterProtocol: AnyObject {
    var launches: [Launch]? { get set }
    init(view: LaunchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, rocketID: String?)
    func getLaunches()
    func tapBack()
}

class LaunchPresenter: LaunchViewPresenterProtocol {
    var launches: [Launch]?
    weak var view: LaunchViewProtocol?
    var router: RouterProtocol?
    let rocketID: String?
    let networkService: NetworkServiceProtocol!
    
    required init(view: LaunchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, rocketID: String?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.rocketID = rocketID
        getLaunches()
    }
    
    func getLaunches() {
        networkService.getLaunches { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let launches):
                    self.launches = launches?.filter({ launch in
                        self.rocketID == launch.rocket
                    })
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func tapBack() {
//        router?.popToRoot()
    }
}
