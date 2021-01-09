//
//  SyntaxFactory+Utilities.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/04.
//

import Foundation
import SwiftSyntax

extension SyntaxFactory {
    static func makeDeclPublicKeywordModifier() -> DeclModifierSyntax {
        SyntaxFactory.makeDeclModifier(
            name: makePublicKeyword(),
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
        )
        .withTrailingTrivia(.spaces(1))
    }
}
