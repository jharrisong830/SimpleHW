//
//  EditClassView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

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
