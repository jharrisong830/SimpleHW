//
//  IconPicker.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct IconPicker: View {
    @Binding var selection: Icon

    var body: some View {
//        Picker("Icon", selection: $selection) {
//            ForEach(Icon.allCases) {icon in
//                IconView(icon: icon)
//                    .tag(icon)
//            }
//        }
//        .pickerStyle(.menu)
        
//        Picker("Icon", selection: $selection) {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(Icon.allCases) { icon in
                        IconView(icon: icon)
                            .tag(icon)
                            .labelStyle(GridIconLabelStyle())
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(icon.id == selection.id ? Color.accentColor : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(Color.secondary)
                            }
                            .padding()
                            .onTapGesture {
                                selection = icon
                            }
                    }
                }
            }
            .navigationTitle("Icon")
//        }
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        IconPicker(selection: .constant(.terminal))
    }
}
