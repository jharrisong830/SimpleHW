//
//  IconWithThemeStyle.swift
//  SimpleHW
//
//  Created by John Graham on 7/3/23.
//

import SwiftUI

struct IconWithThemeStyle: LabelStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .font(.system(size: 14))
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7).frame(width: 28, height: 28).foregroundColor(theme.mainColor))
        }
    }
}
