//
//  Container.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import UIKit

final class Container {
    weak var window: UIWindow?
    static let shared = Container()
}

extension Container {
    func home() {
        DispatchQueue.main.async {
            self.window?.rootViewController = UINavigationController(rootViewController: ListBuilder().build())
            self.window?.makeKeyAndVisible()
        }
    }
}
