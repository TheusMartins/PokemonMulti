//
//  Reusable.swift
//
//
//  Created by Scizor on 5/8/24.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
extension UITableViewCell: Reusable { }
