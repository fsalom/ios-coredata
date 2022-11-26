//
//  ListCryptoBuilder.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation
import UIKit

final class ListBuilder: ListBuilderProtocol {
    func build() -> ListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ListViewController") as ListViewController
        let router = ListRouter(viewController: viewController)
        let characterRepository = CryptoRepository()
        let useCase = CryptoUseCase(repository: characterRepository)
        let viewModel = ListViewModel(router: router, cryptoUseCase: useCase)
        viewController.viewModel = viewModel
        return viewController
    }
}
