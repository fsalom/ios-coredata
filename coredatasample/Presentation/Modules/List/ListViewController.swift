//
//  ViewController.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 20/11/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBindings()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupBindings() {
        viewModel.listCryptoUpdated = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "CryptoCell", bundle: nil),
                                forCellReuseIdentifier: "CryptoCell")
        self.tableView.rowHeight = 60
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cryptos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoCell
        cell.crypto = viewModel.cryptos[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
