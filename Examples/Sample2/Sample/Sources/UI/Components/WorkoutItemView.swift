//
//  WorkoutItemView.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 21. 03. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import SwiftUI

public struct WorkoutItemView: View {
    let title: String
    let time: String
    let workouts: String
    let onClick: () -> Void
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.f17bold)
                .foregroundStyle(.primary)
            
            
            Text(time)
                .font(.f13regular)
                .foregroundStyle(.primary)
                .padding(.top, 8)
            
            Text(workouts)
                .font(.f13regular)
                .foregroundStyle(.primary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 6).fill(Color.surface))
        .onTapGesture(perform: onClick)
    }
}

#Preview {
    VStack(alignment: .leading) {
        WorkoutItemView(title: "title", time: "time", workouts: "workouts") {}.padding(24)
        
        Spacer()
    }.background(Color.screenBackground)
}
