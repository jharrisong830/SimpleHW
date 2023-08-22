//
//  CompletedAssignmentView.swift
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

struct CompletedAssignmentView: View {
    @Binding var course: Class
    @Binding var assignm: Assignment
    
    @State private var restorePressed = false
    @State private var deletePressed = false
    
    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Label("Name", systemImage: "textformat")
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
                    Spacer()
                    Text(assignm.name)
                }
                HStack {
                    Label("Course", systemImage: course.icon.symbol)
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
                    Spacer()
                    Text(course.displayName)
                }
                HStack {
                    Label("Due Date", systemImage: "calendar")
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
                    Spacer()
                    Text(assignm.dueDate.formatted(.dateTime.day().month()))
                }
                HStack {
                    Label("Notification", systemImage: "bell.badge.fill")
                        .labelStyle(IconWithThemeStyle(theme: course.theme))
                    Spacer()
                    if assignm.notifEnabled {
                        Text(assignm.notifDate.formatted(.dateTime.day().month().hour().minute()))
                    }
                    else {
                        Text("Disabled").foregroundStyle(.secondary)
                    }
                }
            }
            Section(header: Text("Status")) {
                Button {
                    assignm.notifEnabled = false
                    course.assignments.append(assignm)
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                    course.completedAssignments.remove(at: course.completedAssignments.firstIndex(of: assignm)!)
                    restorePressed = true
                } label: {
                    Text("Restore Assignment")
                }
                .disabled(restorePressed || deletePressed || !course.completedAssignments.contains(assignm))
                Button(role: .destructive) {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                    course.completedAssignments.remove(at: course.completedAssignments.firstIndex(of: assignm)!)
                    deletePressed = true
                } label: {
                    Text("Delete Assignment")
                }
                .disabled(deletePressed || restorePressed || !course.completedAssignments.contains(assignm))
            }
            Section(header: Text("Notes")) {
                Text(assignm.notes)
            }
        }
        .navigationTitle(assignm.name)
    }
}

struct CompletedAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedAssignmentView(course: .constant(Class.sampleClasses[0]), assignm: .constant(Class.sampleClasses[0].assignments[0]))
    }
}
