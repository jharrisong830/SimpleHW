//
//  ToDoView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct ToDoView: View {
    @Binding var classes: [Class]
    
    var body: some View {
        NavigationStack {
            if classes.isEmpty {
                HStack {
                    Text("There are no assignments. You can add assignments by visiting the details page for a class.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .navigationTitle("To Do")
            }
            else {
                List {
                    ForEach($classes) { $course in
                        if !course.assignments.isEmpty {
                            Section(header: Text(course.displayName)) {
                                ForEach($course.orderedAssignments) { $assignm in
                                    NavigationLink(destination: AssignmentView(course: course, assignm: $assignm)
                                        .navigationTitle(assignm.name)) {
                                        HStack {
                                            Text(assignm.name)
                                                .foregroundColor(course.theme.accentColor)
                                            Spacer()
                                            if assignm.isAlmostDue() {
                                                Label(assignm.dueDate.formatted(.dateTime.day().month()), systemImage: "exclamationmark.triangle.fill")
                                                    .labelStyle(.trailingIcon)
                                                    .fontWeight(.bold)
                                            }
                                            else {
                                                Text(assignm.dueDate.formatted(.dateTime.day().month()))
                                            }
                                        }
                                    }
                                        .listRowBackground(course.theme.mainColor)
                                        .listRowSeparatorTint(course.theme.accentColor)
                                }
                                .onDelete { indices in
                                    course.orderedAssignments.remove(atOffsets: indices)
                                }
                            }
                        }
                        else {
                            Section(header: Text(course.displayName), footer: Text("No assignments for \(course.displayName).").font(.headline)) {
                                EmptyView()
                            }
                        }
                    }
                }
                .navigationTitle("To Do")
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(classes: .constant(Class.sampleClasses))
    }
}
