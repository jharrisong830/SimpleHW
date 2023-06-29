//
//  CompletedAssignmentView.swift
//  SimpleHW
//
//  Created by John Graham on 6/28/23.
//

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
                    Spacer()
                    Text(assignm.name)
                }
                HStack {
                    Label("Course", systemImage: "book.closed.fill")
                    Spacer()
                    Text(course.displayName)
                }
                HStack {
                    Label("Due Date", systemImage: "calendar")
                    Spacer()
                    if assignm.isAlmostDue() {
                        Label(assignm.dueDate.formatted(.dateTime.day().month()), systemImage: "exclamationmark.triangle.fill")
                            .labelStyle(.trailingIcon)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    else {
                        Text(assignm.dueDate.formatted(.dateTime.day().month()))
                    }
                }
                HStack {
                    Label("Notification", systemImage: "bell.badge.fill")
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
