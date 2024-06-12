//
//  Text.swift
//
//
//  Created by Scizor on 5/2/24.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

public class Text: UILabel {
    public var type: TextType {
        didSet {
            setupFont()
        }
    }
    
    public init(type: TextType) {
        self.type = type
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupFont()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFont() {
        self.font = type.font()
        self.textColor = type.textColor
    }
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override public func textRect(
        forBounds bounds: CGRect,
        limitedToNumberOfLines numberOfLines: Int
    ) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(
            forBounds: insetRect,
            limitedToNumberOfLines: numberOfLines
        )
        let invertedInsets = UIEdgeInsets(
            top: -textInsets.top,
            left: -textInsets.left,
            bottom: -textInsets.bottom,
            right: -textInsets.right
        )
        return textRect.inset(by: invertedInsets)
    }
    
    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
#endif

public struct TextView: UIViewRepresentable {
    var text: String
    var type: TextType
    var textInsets: UIEdgeInsets

    public func makeUIView(context: Context) -> UILabel {
        let label = Text(type: type)
        label.text = text
        label.textInsets = textInsets
        return label
    }

    public func updateUIView(_ uiView: UILabel, context: Context) {
        guard let label = uiView as? Text else { return }
        label.text = text
        label.type = type
        label.textInsets = textInsets
    }
}
