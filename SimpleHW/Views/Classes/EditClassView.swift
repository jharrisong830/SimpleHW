//
//  EditClassView.swift
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

struct EditClassView: View {
    @Binding var course: Class
    @State private var pickingIcon = false
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $course.title)
                TextField("Nickname", text: $course.code)
                HStack {
                    Slider(value: $course.creditsAsDouble, in: 0...9, step: 1) {
                        Text("Credits")
                    }
                    Spacer()
                    Text("\(course.credits) credits")
                }
            }
            Section(header: Text("Customization")) {
                Button {
                    pickingIcon = true
                } label: {
                    HStack {
                        Text("Icon")
                            .foregroundColor(.primary)
                        Spacer()
                        IconView(icon: course.icon)
                            .labelStyle(TrailingIconLabelStyle())
                            .foregroundColor(.accentColor)
//                        Image(systemName: "chevron.right")
//                        .foregroundColor(.accentColor)
                    }
                }
                ThemePicker(selection: $course.theme)
            }
            .navigationDestination(isPresented: $pickingIcon) {
                IconPicker(selection: $course.icon, pickingIcon: $pickingIcon)
            }
        }
    }
}

struct EditClassView_Previews: PreviewProvider {
    static var previews: some View {
        EditClassView(course: .constant(Class.sampleClasses[0]))
    }
}
