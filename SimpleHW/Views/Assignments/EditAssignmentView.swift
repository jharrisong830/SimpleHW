//
//  EditAssignmentView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI
import UserNotifications

struct EditAssignmentView: View {
    let course: Class
    @Binding var assignm: Assignment
    @State var notifError = false
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Name", text: $assignm.name)
                DatePicker("Due Date", selection: $assignm.dueDate, displayedComponents: [.date])
                    .datePickerStyle(.compact)
            }
            Section(header: Text("Notifications")) {
                if assignm.notifEnabled {
                    Button("Disable Notifications") {
                        assignm.notifEnabled = false
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignm.id.uuidString])
                    }
                    DatePicker("Notification Date", selection: $assignm.notifDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                }
                else {
                    Button("Enable Notifications") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                assignm.notifEnabled = true
                            }
                            notifError = !assignm.notifEnabled
                        }
                    }
                    .alert("Notifications not enabled for Homework Tracker", isPresented: $notifError, actions: {}, message: { Text("Go to Settings and enable notifications for Homework Tracker to be able to schedule notifications for your assignments.") } )
                }
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $assignm.notes)
            }
        }
    }
}

struct EditAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        EditAssignmentView(course: Class.sampleClasses[0], assignm: .constant(Assignment.sampleAssignments[0]))
    }
}
