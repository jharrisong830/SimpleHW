//
//  AssignmentView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct AssignmentView: View {
    @Binding var course: Class
    @Binding var assignm: Assignment
    @State private var isEditing = false
    @State private var editingAssignment = Assignment.emptyAssignment
    
    @State private var completePressed = false
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
                    course.completedAssignments.append(assignm)
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                    course.orderedAssignments.remove(at: course.assignments.firstIndex(of: assignm)!)
                    completePressed = true
                } label: {
                    Text("Mark as Completed")
                }
                .disabled(completePressed || deletePressed || !course.assignments.contains(assignm))
                Button(role: .destructive) {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                    course.orderedAssignments.remove(at: course.assignments.firstIndex(of: assignm)!)
                    deletePressed = true
                } label: {
                    Text("Delete Assignment")
                }
                .disabled(deletePressed || completePressed || !course.assignments.contains(assignm))
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
                                editingAssignment.dueDate = editingAssignment.getEODTime()
                                assignm=editingAssignment
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                    if success && assignm.notifEnabled {
                                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = "\(assignm.name) - \(course.displayName)"
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
        AssignmentView(course: .constant(Class.sampleClasses[0]), assignm: .constant(Class.sampleClasses[0].assignments[0]))
    }
}
