//
//  IconPicker.swift
//  Copyright (C) 2023  John Graham
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import SwiftUI

struct IconPicker: View {
    @Binding var selection: Icon
    @Binding var pickingIcon: Bool

    var body: some View {
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
                            pickingIcon = false
                        }
                }
            }
        }
        .navigationTitle("Icon")
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        IconPicker(selection: .constant(.terminal), pickingIcon: .constant(true))
    }
}
