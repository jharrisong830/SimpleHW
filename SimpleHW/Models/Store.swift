//
//  Store.swift
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

@MainActor
class ClassStore: ObservableObject {
    @Published var classes: [Class] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("classes.data")
    }
    
    func load() async throws {
        let task = Task<[Class], Error> {
            let fileURL = try Self.fileURL()
            print(fileURL)
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let allClasses = try JSONDecoder().decode([Class].self, from: data)
            return allClasses
        }
        let classes = try await task.value
        self.classes=classes
    }
    
    func save(classes: [Class]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(classes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
