//
//  PresentationDetent+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import SwiftUI

extension PresentationDetent {
    static let filter: PresentationDetent = Self.custom(FilterDetent.self)
}

private struct FilterDetent: CustomPresentationDetent {

    static internal func height(
        in context: Context
    ) -> CGFloat? {
        max(300, context.maxDetentValue * 0.3)
    }
}
