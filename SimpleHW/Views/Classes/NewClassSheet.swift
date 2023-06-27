//
//  NewClassSheet.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct NewClassSheet: View {
    @Binding var classes: [Class]
    @Binding var isCreating: Bool
    @State private var newCourse = Class.emptyCourse
    
    var body: some View {
        NavigationStack {
            EditClassView(course: $newCourse)
                .navigationTitle("New course")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isCreating=false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            classes.append(newCourse)
                            isCreating=false
                        }
                        .disabled(newCourse.title.isEmpty)
                    }
                }
        }
    }
}

struct NewClassSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewClassSheet(classes: .constant(Class.sampleClasses), isCreating: .constant(true))
    }
}
