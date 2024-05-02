//
//  Text.swift
//
//
//  Created by Scizor on 5/2/24.
//

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
