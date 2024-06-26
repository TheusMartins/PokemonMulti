//
//  Reusable.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit


public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: Reusable { }
#endif
