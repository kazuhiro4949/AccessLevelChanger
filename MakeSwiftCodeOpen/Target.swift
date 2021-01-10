//
//  Target.swift
//  SwiftDIHelper
//
//  Created by Kazuhiro Hayashi on 2021/01/09.
//

import Foundation

enum Target: Int, Hashable, CaseIterable {
    case `class`
    case `struct`
    case `enum`
    case `protocol`
    case `extension`
    case variable
    case function
    case `init`
    case `subscript`
    case `typealias`
    case `associatedtype`
}

extension Dictionary where Key == Target, Value == Bool {
    static let `default`: [Target: Bool] = Target
        .allCases
        .reduce(into: [Target: Bool]()) { (result, target) in
            result[target] = true
        }
    
    func export() -> [String: Bool] {
        reduce(into: [String: Bool]()) { (result, elem) in
            result["\(elem.key.rawValue)"] = elem.value
        }
    }
    
    static func make(_ rawValue: [String: Bool]) -> [Target: Bool] {
        return rawValue.reduce(into: [Target: Bool]()) { (result, elem) in
            if let int = Int(elem.key), let target = Target(rawValue: int) {
                result[target] = elem.value
            }
        }
    }
}

extension UserDefaults {
    static let appGroups = UserDefaults(
        suiteName: "R33Y42SDDR.kazuhiro.hayashi.MakeSwiftCodeOpen"
    )!
    
    static var disabledNestedDecl: String = "disabledNestedDecl"
    static var targetStatesKey: String = "targetStates"
}

