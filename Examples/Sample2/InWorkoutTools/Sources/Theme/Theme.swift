//
//  Theme.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 8. 03. 24.
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

extension Color {
    public static let screenBackground = Color(hex: "FFF2F2F2")
    public static let onBackground = Color(hex: "FF181818")
    public static let surface = Color(hex: "FFFFFFFF")
    
    public static let primary = Color(hex: "FF181818")
    public static let primary08opacity = Color(hex: "CC181818")
    public static let secondary = Color(hex: "FF888888")
    public static let thertiary = Color(hex: "FF888888")
    
    public static let accent = Color(hex: "FF02AFEF")
}

extension Font {
    
    public static let f70bold: Font = .system(size: 70, weight: .bold)
    public static let f25bold: Font = .system(size: 25, weight: .bold)
    public static let f21bold: Font = .system(size: 21, weight: .bold)
    public static let f21regular: Font = .system(size: 21, weight: .regular)
    public static let f17bold: Font = .system(size: 17, weight: .bold)
    public static let f17regular: Font = .system(size: 17, weight: .regular)
    public static let f15regular: Font = .system(size: 15, weight: .regular)
    public static let f13regular: Font = .system(size: 13, weight: .regular)
    public static let f13bold: Font = .system(size: 13, weight: .bold)
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct PrimaryButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.horizontal, 16)
            .font(.f17bold)
    }
}

struct InversePrimaryButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.white)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.horizontal, 16)
            .font(.f17bold)
    }
}

struct SecondaryButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 25)
            .frame(height: 36)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .font(.f13bold)
    }
}

struct PlusButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .font(.f21bold)
            .padding(.trailing, 10)
    }
}

struct DeleteWorkoutButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.f13bold)
            .underline()
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.primary)
            .padding(.vertical, 30)
    }
}

struct AddExerciseButton: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 60, height: 30)
            .font(.f13bold)
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 4).fill(.primary))
            .padding(.trailing, 15)
    }
}

struct HeaderText: LabelStyle {
    func makeBody(configuration: LabelStyle.Configuration) -> some View {
        configuration.title
            .font(.f21bold)
    }
}

extension ButtonStyle where Self == PrimaryButton {
    static var primaryButton: Self { PrimaryButton() }
}

extension ButtonStyle where Self == InversePrimaryButton {
    static var inversePrimaryButton: Self { InversePrimaryButton() }
}

extension ButtonStyle where Self == SecondaryButton {
    static var secondaryButton: Self { SecondaryButton() }
}

extension ButtonStyle where Self == PlusButton {
    static var plusButton: Self { PlusButton() }
}

extension ButtonStyle where Self == DeleteWorkoutButton {
    static var deleteWorkoutButton: Self { DeleteWorkoutButton() }
}

extension ButtonStyle where Self == AddExerciseButton {
    static var addExerciseButton: Self { AddExerciseButton() }
}

extension LabelStyle where Self == HeaderText {
    static var headerText: Self { HeaderText() }
}

struct Theme_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Primary text")
                .font(.f21bold)
                .foregroundStyle(.primary)
            
            Button("primaryButton") {
                
            }.buttonStyle(.primaryButton)
            
            Button("inversePrimaryButton") {
                
            }.buttonStyle(.inversePrimaryButton)
            
            Button("SecondaryButton") {
                
            }.buttonStyle(.secondaryButton)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.teal)
    }
}
