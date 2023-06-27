//
//  EditClassView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct EditClassView: View {
    @Binding var course: Class
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $course.title)
                TextField("Nickname", text: $course.code)
                HStack {
                    Slider(value: $course.creditsAsDouble, in: 0...4, step: 1) {
                        Text("Credits")
                    }
                    Spacer()
                    Text("\(course.credits) credits")
                }
            }
            Section(header: Text("Customization")) {
                NavigationLink(destination: IconPicker(selection: $course.icon)) {
                    HStack {
                        Text("Icon")
                        Spacer()
                        IconView(icon: course.icon)
                                .labelStyle(TrailingIconLabelStyle())
                    }
                }
                ThemePicker(selection: $course.theme)
            }
        }
    }
}

struct EditClassView_Previews: PreviewProvider {
    static var previews: some View {
        EditClassView(course: .constant(Class.sampleClasses[0]))
    }
}
