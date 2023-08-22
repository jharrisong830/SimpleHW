//
//  ClassListView.swift
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

struct ClassListView: View {
    @Binding var classes: [Class]
    @State var isCreating = false
    
    var body: some View {
        NavigationStack {
            if classes.isEmpty {
                HStack {
                    (Text("Press the ") + Text(Image(systemName: "plus.circle")) + Text(" button to get started."))
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .navigationTitle("Classes")
                .toolbar {
                    Button(action: {
                        isCreating=true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            else {
                List {
                    ForEach($classes) { $course in
                        NavigationLink(destination: ClassView(course: $course)) {
                            CardView(course: course)
                        }
                        .listRowBackground(course.theme.mainColor)
                    }
                    .onMove { source, index in
                        classes.move(fromOffsets: source, toOffset: index)
                    }
                    .onDelete { indices in
                        classes.remove(atOffsets: indices)
                    }
                }
                .navigationTitle("Classes")
                .toolbar {
                    EditButton()
                    Button(action: {
                        isCreating=true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $isCreating) {
            NewClassSheet(classes: $classes, isCreating: $isCreating)
        }
    }
}

struct ClassListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassListView(classes: .constant(Class.sampleClasses))
    }
}
