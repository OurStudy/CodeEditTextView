//
//  Loopable.swift
//  CodeEditModules/AppPreferences
//
//  Created by Lukas Pistrol on 03.04.22.
//

import Foundation

/// Loopable protocol implements a method that will return all child
/// properties and their associated values of a `Type`
public protocol Loopable {
    func allProperties() throws -> [String: Any]
}

public extension Loopable {

    /// returns all child properties and their associated values of `self`
    ///
    /// **Example:**
    /// ```swift
    /// struct Author: Loopable {
    ///   var name: String = "Steve"
    ///   var books: Int = 4
    /// }
    ///
    /// let author = Author()
    /// print(author.allProperties())
    ///
    /// // returns
    /// ["name": "Steve", "books": 4]
    /// ```
    func allProperties() throws -> [String: Any] {
        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }

        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }

            result[property] = value
        }

        return result
    }
}
