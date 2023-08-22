//
//  AddAssignmentView.swift
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
                            newAssignment.dueDate = newAssignment.getEODTime()
                            assignments.append(newAssignment)
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success && newAssignment.notifEnabled {
                                    let content = UNMutableNotificationContent()
                                    content.title = "\(newAssignment.name) - \(course.displayName)"
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
