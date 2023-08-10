//
//  Publisher+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 14/04/2023.
//

import Combine
import SwiftUI

extension Publisher {
    internal func tryAwaitMap<T>(
        _ transform: @escaping (Self.Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let result: T = try await transform(value)
                        promise(.success(result))
                    }
                }
            }
        }
    }
}
