//
//  MainPagePresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var rockets: [Rocket]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getRockets() // make REALM
}

class MainPresenter: MainViewPresenterProtocol {
    var rockets: [Rocket]?
    weak var view: MainViewProtocol?
    let network: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.network = networkService
        getRockets()
    }
    func getRockets() {
        network.getRockets { [weak self] result in
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
}
