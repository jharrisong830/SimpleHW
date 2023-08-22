//
//  NewClassSheet.swift
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
