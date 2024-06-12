//
//  SwiftUIPrimaryButton.swift
//
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

struct SwiftUIPrimaryButton: View {
    enum Layout {
        case wide
        case thin
        case fixed

        var cornerRadius: CGFloat {
            switch self {
            case .wide, .thin:
                return CGFloat(CGFloat.Measure.measure8)
            default:
                return .zero
            }
        }

        var height: CGFloat {
            switch self {
            case .wide:
                return CGFloat(CGFloat.Measure.measure48)
            case .thin:
                return CGFloat(CGFloat.Measure.measure40)
            case .fixed:
                return CGFloat(CGFloat.Measure.measure56)
            }
        }
    }

    @State private var isAnimating: Bool = false
    @State private var isEnabled: Bool = true
    @State private var title: String? = "Button"
    var layout: Layout = .wide
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            if isAnimating {
                SpinnerLoaderView(isAnimating: $isAnimating, color: UIColor.TextColors.background)
                    .frame(width: .Measure.measure32, height: .Measure.measure32)
            } else {
                TextView(text: title ?? "", type: .button, textInsets: .init(top: .zero, left: .zero, bottom: .zero, right: .zero))
                    .font(TextType.helperText.swiftUIFont())
                    .foregroundColor(isEnabled ? Color.TextColors.textPrimary : Color.TextColors.textDisabled)
                    .frame(maxWidth: .infinity)
                    .frame(height: layout.height)
                    .background(isEnabled ? Color.BrandColors.pikachuYellow : Color(.darkGray))
                    .cornerRadius(layout.cornerRadius)
            }
        }
        .disabled(!isEnabled)
        .onAppear {
            setLayout()
        }
    }

    private func setLayout() {
        // This function can be used to update any additional layout properties if needed
    }

    func startLoader() {
        title = ""
        isAnimating = true
        isEnabled = false
    }

    func stopLoader() {
        isAnimating = false
        isEnabled = true
        title = "Button"
    }
}

// Preview Provider
struct SwiftUIPrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIPrimaryButton(layout: .wide, action: {
                print("Button pressed")
            })
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Wide Layout")

            SwiftUIPrimaryButton(layout: .thin, action: {
                print("Button pressed")
            })
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Thin Layout")

            SwiftUIPrimaryButton(layout: .fixed, action: {
                print("Button pressed")
            })
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Fixed Layout")
        }
    }
}
