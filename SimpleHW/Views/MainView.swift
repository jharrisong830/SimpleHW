//
//  MainView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

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
