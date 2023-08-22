//
//  CardView.swift
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

struct CardView: View {
    let course: Class
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.title)
                .font(.headline)
            Spacer()
            HStack {
                if course.code == "" {
                    EmptyView()
                }
                else {
                    Text("\(course.code)")
                }
                Spacer()
                Text("Credits: \(course.credits)")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(course.theme.accentColor)
        .overlay(alignment: .leading) {
            Image(systemName: course.icon.symbol)
                .foregroundColor(course.theme.accentColor)
                .font(.system(size: 50))
                .opacity(0.10)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var course = Class.sampleClasses[0]
    static var previews: some View {
        CardView(course: course)
            .background(course.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
