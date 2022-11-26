//
//  DataResponseDTO.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

struct DataNetworkResponse<T: Codable>: Codable {
    let data: T?

    init(data: T?) {
        self.data = data
    }
}
