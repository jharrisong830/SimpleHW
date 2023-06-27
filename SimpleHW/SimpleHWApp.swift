//
//  SimpleHWApp.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

import SwiftUI

@main
struct SimpleHWApp: App {
    @StateObject private var store = ClassStore()
    @State private var errorWrapper: ErrorWrapper?

    var body: some Scene {
        WindowGroup {
            MainView(classes: $store.classes) {
                Task {
                    do {
                        try await store.save(classes: store.classes)
                    } catch {
                        errorWrapper=ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper=ErrorWrapper(error: error, guidance: "The app will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.classes=Class.sampleClasses
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
        }
    }
}
