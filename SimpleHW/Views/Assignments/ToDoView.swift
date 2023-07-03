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
                    Text("There are no assignments. Get started by adding a class, then add some assignments to see them here.")
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
                                    NavigationLink(destination: AssignmentView(course: $course, assignm: $assignm)
                                        .navigationTitle(assignm.name)) {
                                            HStack {
                                                Text(assignm.name)
                                                    .foregroundColor(course.theme.accentColor)
                                                Spacer()
                                                if assignm.isAlmostDue() {
                                                    Label(assignm.dueDate.formatted(.dateTime.day().month()), systemImage: "exclamationmark.triangle.fill")
                                                        .labelStyle(.trailingIcon)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(course.theme.accentColor)
                                                }
                                                else {
                                                    Text(assignm.dueDate.formatted(.dateTime.day().month()))
                                                    .foregroundColor(course.theme.accentColor)
                                                }
                                            }
                                        }
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                                                course.orderedAssignments.remove(at: course.assignments.firstIndex(of: assignm)!)
                                                
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            Button {
                                                assignm.notifEnabled = false
                                                course.completedAssignments.append(assignm)
                                                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                                                course.orderedAssignments.remove(at: course.assignments.firstIndex(of: assignm)!)
                                            } label: {
                                                Label("Mark As Completed", systemImage: "checkmark.circle.fill")
                                            }
                                            .tint(.green)
                                        }
                                        .listRowBackground(course.theme.mainColor)
                                        .listRowSeparatorTint(course.theme.accentColor)
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
