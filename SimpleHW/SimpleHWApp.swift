//
//  SimpleHWApp.swift
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
