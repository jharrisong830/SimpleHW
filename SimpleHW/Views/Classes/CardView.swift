//
//  CardView.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

struct CardView: View {
    let course: Class
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.title)
                .font(.headline)
            Spacer()
            HStack {
                if course.title == course.code {
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
