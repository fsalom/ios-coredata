//
//  UpdateInformation.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 28/11/22.
//

import Foundation

struct UpdateInformation: Hashable {
    let name: String
    let date: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: UpdateInformation, rhs: UpdateInformation) -> Bool {
        lhs.name == rhs.name
    }

    init(name: String, date: String) {
        self.name = name
        self.date = date
    }
}
