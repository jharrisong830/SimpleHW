//
//  ClassView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

import SwiftUI
import UserNotifications

struct ClassView: View {
    @Binding var course: Class
    @State private var isEditing = false
    @State private var editingCourse = Class.emptyCourse
    @State private var isAssignment = false
    
    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Label("Title", systemImage: course.icon.symbol)
                    Spacer()
                    Text(course.title)
                }
                HStack {
                    Label("Nickname", systemImage: "textformat.123")
                    Spacer()
                    if course.code.isEmpty {
                        Text("None")
                            .foregroundStyle(.secondary)
                    }
                    else {
                        Text(course.code)
                    }
                }
                HStack {
                    Label("Credits", systemImage: "book.closed.fill")
                    Spacer()
                    Text("\(course.credits)")
                }
            }
            if course.assignments.isEmpty {
                Section(header: Text("Assignments"), footer:
                    (Text("Press the ") + Text(Image(systemName: "plus.circle")) + Text(" button to get started."))
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)) {
                    EmptyView()
                }
            }
            else {
                Section(header: Text("Assignments")) {
                    ForEach($course.orderedAssignments) { $assignm in
                        NavigationLink(destination: AssignmentView(course: $course, assignm: $assignm)
                            .navigationTitle(assignm.name)) {
                                HStack {
                                    Text(assignm.name)
                                    Spacer()
                                    if assignm.isAlmostDue() {
                                        Text(assignm.dueDate.formatted(.dateTime.day().month()))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.red)
                                    }
                                    else {
                                        Text(assignm.dueDate.formatted(.dateTime.day().month()))
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
                    }
                }
            }
        }
        .navigationTitle(course.title)
        .toolbar {
            Button("Edit") {
                isEditing=true
                editingCourse=course
            }
            Button(action: {
                isAssignment=true
            }) {
                Image(systemName: "doc.badge.plus")
            }
        }
        .sheet(isPresented: $isEditing) {
            NavigationStack {
                EditClassView(course: $editingCourse)
                    .navigationTitle(course.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isEditing=false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isEditing=false
                                course=editingCourse
                            }
                            .disabled(editingCourse.title.isEmpty)
                        }
                    }
            }
        }
        .sheet(isPresented: $isAssignment) {
            AddAssignmentView(course: course, assignments: $course.assignments, isCreating: $isAssignment)
        }
    }
}

struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView(course: .constant(Class.sampleClasses[0]))
            .background(Class.sampleClasses[0].theme.mainColor)
    }
}
