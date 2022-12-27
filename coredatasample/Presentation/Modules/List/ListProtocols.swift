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
    func refreshCryptos()

    var cryptos: [Crypto] { get set }
    var listCryptoUpdated: (() -> Void)? { get set }
    var errorHasOcurred: ((Error) -> Void)? { get set }
}
