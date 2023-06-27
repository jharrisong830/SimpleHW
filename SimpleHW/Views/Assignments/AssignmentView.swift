//
//  AssignmentView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct AssignmentView: View {
    let course: Class
    @Binding var assignm: Assignment
    @State private var isEditing = false
    @State private var editingAssignment = Assignment.emptyAssignment
    
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
            Section(header: Text("Notes")) {
                Text(assignm.notes)
            }
        }
        .navigationTitle(assignm.name)
        .toolbar {
            Button("Edit") {
                isEditing=true
                editingAssignment=assignm
            }
        }
        .sheet(isPresented: $isEditing) {
            NavigationStack {
                EditAssignmentView(course: course, assignm: $editingAssignment)
                    .navigationTitle(assignm.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isEditing=false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isEditing=false
                                assignm=editingAssignment
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                    if success && assignm.notifEnabled {
                                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = "\(assignm.name) - \(course.code)"
                                        content.subtitle = "Due \(assignm.notifDate.formatted(.dateTime.day().month()))"
                                        content.sound = UNNotificationSound.default

                                        let timeInt = max(assignm.notifDate.timeIntervalSince(Date.now), 1)
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInt, repeats: false)
                                        let request = UNNotificationRequest(identifier: assignm.id.uuidString, content: content, trigger: trigger)
                                        UNUserNotificationCenter.current().add(request)
                                    }
                                }
                            }
                            .disabled(editingAssignment.name.isEmpty)
                        }
                    }
            }
        }
    }
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(course: Class.sampleClasses[0], assignm: .constant(Class.sampleClasses[0].assignments[0]))
    }
}
