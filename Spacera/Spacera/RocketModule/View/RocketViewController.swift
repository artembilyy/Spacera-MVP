//
//  RocketViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import UIKit

class RocketViewController: UIViewController {
    
    var presenter: RocketViewPresenterProtocol!
    var index: Int!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension RocketViewController: RocketViewProtocol {
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func success() {
        tableView.reloadData()
    }
}

extension RocketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rockets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let rocket = presenter.rockets?[indexPath.row]
        cell.textLabel?.text = rocket?.name
        return cell
    }
    
    
}

extension RocketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocket = presenter.rockets?[indexPath.row]
        presenter.showLaunches(rocketID: rocket?.id)
    }
}

