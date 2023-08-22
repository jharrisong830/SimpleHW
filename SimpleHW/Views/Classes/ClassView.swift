//
//  ClassView.swift
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
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
                    Spacer()
                    Text(course.title)
                }
                HStack {
                    Label("Nickname", systemImage: "textformat")
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
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
                    Label("Credits", systemImage: "checkmark.seal.fill")
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
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
