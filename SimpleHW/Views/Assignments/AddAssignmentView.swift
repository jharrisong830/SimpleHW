//
//  AddAssignmentView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct AddAssignmentView: View {
    let course: Class
    @Binding var assignments: [Assignment]
    @Binding var isCreating: Bool
    @State private var newAssignment = Assignment.emptyAssignment
    
    var body: some View {
        NavigationStack {
            EditAssignmentView(course: course, assignm: $newAssignment)
                .navigationTitle("New assignment")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isCreating=false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            assignments.append(newAssignment)
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success && newAssignment.notifEnabled {
                                    let content = UNMutableNotificationContent()
                                    content.title = "\(newAssignment.name) - \(course.code)"
                                    content.subtitle = "Due \(newAssignment.notifDate.formatted(.dateTime.day().month()))"
                                    content.sound = UNNotificationSound.default

                                    let timeInt = max(newAssignment.notifDate.timeIntervalSince(Date.now), 1)
                                    
                                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInt, repeats: false)
                                    let request = UNNotificationRequest(identifier: newAssignment.id.uuidString, content: content, trigger: trigger)
                                    UNUserNotificationCenter.current().add(request)
                                }
                            }
                            isCreating=false
                        }
                        .disabled(newAssignment.name.isEmpty)
                    }
                }
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(course: Class.sampleClasses[0], assignments: .constant(Class.sampleClasses[0].assignments), isCreating: .constant(true))
    }
}
