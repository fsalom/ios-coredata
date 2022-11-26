//
//  ListProtocols.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

protocol ListBuilderProtocol {
    func build() -> ListViewController
}

protocol ListRouterProtocol {

}

protocol ListViewModelProtocol {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
}
