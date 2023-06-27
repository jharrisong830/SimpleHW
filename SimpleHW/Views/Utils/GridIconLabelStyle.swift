//
//  GridIconLabelStyle.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct GridIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.largeTitle)
            Spacer()
            configuration.title
                .font(.caption)
        }
    }
}

extension LabelStyle where Self == GridIconLabelStyle {
    static var gridIcon: Self {Self()}
}
