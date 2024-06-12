//
//  SwiftUISecondaryButton.swift
//
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

struct SwiftUISecondaryButton: View {
    enum Layout {
        case wide
        case thin

        var cornerRadius: CGFloat {
            switch self {
            case .wide, .thin:
                return CGFloat(CGFloat.Measure.measure8)
            }
        }

        var height: CGFloat {
            switch self {
            case .wide:
                return CGFloat(CGFloat.Measure.measure48)
            case .thin:
                return CGFloat(CGFloat.Measure.measure40)
            }
        }
    }

    @State private var isEnabled: Bool = true
    @State private var title: String? = "Button"
    var layout: Layout = .wide
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            TextView(text: title ?? "", type: .button, textInsets: .init())
                .font(TextType.button.swiftUIFont())
                .foregroundColor(isEnabled ? Color.TextColors.textPrimary : Color.TextColors.textDisabled)
                .frame(maxWidth: .infinity)
                .frame(height: layout.height)
                .background(Color.BrandColors.pokeballRed)
                .cornerRadius(layout.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: layout.cornerRadius)
                        .stroke(Color.BrandColors.pikachuYellow, lineWidth: CGFloat.Measure.measure1)
                )
        }
        .disabled(!isEnabled)
        .onAppear {
            setLayout()
        }
    }

    private func setLayout() {
        // This function can be used to update any additional layout properties if needed
    }
}

// Preview Provider
struct SwiftUISecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUISecondaryButton(layout: .wide, action: {
                print("Button pressed")
            })
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Wide Layout")

            SwiftUISecondaryButton(layout: .thin, action: {
                print("Button pressed")
            })
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Thin Layout")
        }
    }
}
