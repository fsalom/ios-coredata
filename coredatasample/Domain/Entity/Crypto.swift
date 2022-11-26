//
//  Crypto.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

struct Crypto: Hashable {
    let name: String
    let priceUsd: String
    let changePercent24Hr : String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: Crypto, rhs: Crypto) -> Bool {
        lhs.name == rhs.name
    }

    init(dto: CryptoDTO) {
        self.name = dto.name
        self.priceUsd = dto.priceUsd
        self.changePercent24Hr = dto.changePercent24Hr
    }
}
