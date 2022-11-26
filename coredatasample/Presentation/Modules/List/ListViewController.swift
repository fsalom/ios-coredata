//
//  ViewController.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 20/11/22.
//

import UIKit

class ListViewController: UIViewController {
    var viewModel: ListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

