//
//  TopView.swift
//  FeatureModels
//
//  Created by Filip Božić on 11. 04. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import SwiftUI

public struct TopView: View {
    public let onBack: () -> Void
    
    public init(onBack: @escaping () -> Void) {
        self.onBack = onBack
    }
    
    public var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                Image(.icBack)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.background)
                    .frame(width: 40, height: 40)
            }
            .frame(width: 40, height: 40)
            .background(Color.onBackground)
            .clipShape(Circle())
            .padding(.horizontal, 24)
            .onTapGesture(perform: onBack)
            
            Spacer()
        }
    }
}
