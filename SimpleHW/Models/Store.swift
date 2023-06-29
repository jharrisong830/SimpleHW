//
//  Store.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

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
