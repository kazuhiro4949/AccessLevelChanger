//
//  DeclModifierSyntax.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/04.
//

import Foundation
import SwiftSyntax

// MARK:- Scope
extension DeclModifierSyntax {
    var isReplacingTargetScopeToPublic: Bool {
        isInternalKeyword && hasNoDetail
    }
    
    var isScope: Bool {
        isPublicKeyword
            || isPrivateKeyword
            || isFileprivateKeyword
            || isInternalKeyword
    }
    
    var isPublicKeyword: Bool {
        name.tokenKind == .publicKeyword
    }
    
    var isPrivateKeyword: Bool {
        name.tokenKind == .privateKeyword
    }
    
    var isFileprivateKeyword: Bool {
        name.tokenKind == .fileprivateKeyword
    }
    
    var isInternalKeyword: Bool {
        name.tokenKind == .internalKeyword
    }
    
    var hasNoDetail: Bool {
         detailLeftParen == nil && detail == nil && detailRightParen == nil
    }
    
    var hasSetDetail: Bool {
        detailLeftParen?.text == "("
            && detail?.text == "set"
            && detailRightParen?.text == ")"
    }
}
