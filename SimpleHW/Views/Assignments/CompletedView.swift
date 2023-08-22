//
//  CompletedView.swift
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

struct CompletedView: View {
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
                .navigationTitle("Completed")
            }
            else {
                List {
                    ForEach($classes) { $course in
                        if !course.completedAssignments.isEmpty {
                            Section(header: Text(course.displayName)) {
                                ForEach($course.completedAssignments) { $assignm in
                                    NavigationLink(destination: CompletedAssignmentView(course: $course, assignm: $assignm)
                                        .navigationTitle(assignm.name)) {
                                            HStack {
                                                Text(assignm.name)
                                                    .foregroundColor(course.theme.accentColor)
                                                Spacer()
                                                Text(assignm.dueDate.formatted(.dateTime.day().month()))
                                                    .foregroundColor(course.theme.accentColor)
                                            }
                                        }
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                course.completedAssignments.remove(at: course.completedAssignments.firstIndex(of: assignm)!)
                                                
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            Button {
                                                course.assignments.append(assignm)
                                                course.completedAssignments.remove(at: course.assignments.firstIndex(of: assignm)!)
                                            } label: {
                                                Label("Restore", systemImage: "checkmark.circle.badge.xmark.fill")
                                            }
                                            .tint(.blue)
                                        }
                                        .listRowBackground(course.theme.mainColor)
                                        .listRowSeparatorTint(course.theme.accentColor)
                                }
                            }
                        }
                        else {
                            Section(header: Text(course.displayName), footer: Text("Nothing completed for \(course.displayName).").font(.headline)) {
                                EmptyView()
                            }
                        }
                    }
                }
                .navigationTitle("Completed")
            }
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(classes: .constant(Class.sampleClasses))
    }
}
