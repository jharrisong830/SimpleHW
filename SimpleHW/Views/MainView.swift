//
//  MainView.swift
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

struct MainView: View {
    @Binding var classes: [Class]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        TabView {
            ClassListView(classes: $classes)
                .tabItem {
                    Label("Classes", systemImage: "graduationcap.fill")
                }
            ToDoView(classes: $classes)
                .badge(classes.reduce(0, {x, y in
                    x + y.numAlmostDue
                }))
                .tabItem {
                    Label("To Do", systemImage: "checklist")
                }
            CompletedView(classes: $classes)
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle.fill")
                }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(classes: .constant(Class.sampleClasses), saveAction: {})
    }
}
