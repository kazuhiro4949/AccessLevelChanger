//
//  DeclSyntaxProtocol+Utilities.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/04.
//

import Foundation
import SwiftSyntax

extension DeclSyntaxProtocol {
    var asDecl: DeclSyntax {
        DeclSyntax(self)
    }
}
