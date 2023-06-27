//
//  IconView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct IconView: View {
    let icon: Icon
    
    var body: some View {
        Label(icon.name, systemImage: icon.symbol)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: .terminal)
            .previewLayout(.sizeThatFits)
    }
}
