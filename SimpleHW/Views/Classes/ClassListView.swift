//
//  ClassListView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

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
                    .onDelete { indices in
                        classes.remove(atOffsets: indices)
                    }
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
