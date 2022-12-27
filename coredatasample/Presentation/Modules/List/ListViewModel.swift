//
//  ListViewModel.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation


final class ListViewModel: ListViewModelProtocol {
    let router: ListRouterProtocol
    var cryptoUseCase: CryptoUseCaseProtocol

    enum Status {
        case searching
        case listing
    }

    var cryptos = [Crypto]() {
        didSet {
            listCryptoUpdated?()
        }
    }

    var listCryptoUpdated: (() -> Void)?
    var errorHasOcurred: ((Error) -> Void)?

    init(router: ListRouterProtocol,
         cryptoUseCase: CryptoUseCaseProtocol) {
        self.router = router
        self.cryptoUseCase = cryptoUseCase
    }
}

extension ListViewModel {
    //MARK: Life cycle
    func viewDidLoad() {
        loadCryptos()
    }

    func viewDidAppear() {
    }

    func viewDidDisappear() {
    }

    func refreshCryptos() {
        loadCryptos(forceUpdate: true)
    }

    //MARK: Actions
    func loadCryptos(forceUpdate: Bool = false) {
        Task {
            do {
                self.cryptos = try await cryptoUseCase.getList(forceUpdate: forceUpdate)
            } catch {
                errorHasOcurred?(error)
            }
        }
    }
}
