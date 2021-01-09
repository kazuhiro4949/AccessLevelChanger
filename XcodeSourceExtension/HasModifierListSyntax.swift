//
//  HasModifierListSyntax.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/04.
//

import Foundation
import SwiftSyntax

//MARK: - Rule fro replaceing with public
extension ModifierListSyntax {
    var hasPublic: Bool {
        return filter(\.isScope)
            .contains(where: { $0.isPublicKeyword })// internal **
    }
    
    var needsReplacingPublic: Bool {
        return filter(\.isScope)
            .contains(where: { $0.isReplacingTargetScopeToPublic })// internal **
    }
    
    var needsAppendPublic: Bool {
        guard !contains(where: { $0.isPublicKeyword }) else { // public
            return false
        }
        
        let scopes = filter(\.isScope)
        if  scopes.isEmpty { // no scope
            return true
        } else if scopes.count == 1, let scope = scopes.first { // private(set) || fileprivate(set)
            return (scope.isPrivateKeyword && scope.hasSetDetail)
                || (scope.isFileprivateKeyword && scope.hasSetDetail)
        }  else {
            return false
        }
    }
}


protocol HasModifierListSyntax {
    var modifiers: ModifierListSyntax? { get }
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> Self
}

extension HasModifierListSyntax {
    func replacingScopeModifiers(with declModifierSyntaxes: [DeclModifierSyntax]) -> ModifierListSyntax? {
        if modifiers?.needsReplacingPublic == true {
            var newModifiers = modifiers?.compactMap({ (modifierSyntax) -> DeclModifierSyntax? in
                if modifierSyntax.isReplacingTargetScopeToPublic {
                    return nil
                } else {
                    return modifierSyntax
                        .withLeadingTrivia(.zero)
                        .withTrailingTrivia(.spaces(1))
                }
            }) ?? []
            newModifiers.insert(contentsOf: declModifierSyntaxes, at: 0)
            return SyntaxFactory.makeModifierList(newModifiers)
        } else if modifiers == nil || modifiers?.needsAppendPublic == true {
            var newModifiers = modifiers?.map {
                $0.withLeadingTrivia(.zero)
                .withTrailingTrivia(.spaces(1))
            } ?? []
            newModifiers.insert(contentsOf: declModifierSyntaxes, at: 0)
            return SyntaxFactory.makeModifierList(newModifiers)
        } else {
            return modifiers
        }
    }
}

extension VariableDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> VariableDeclSyntax {
        withLetOrVarKeyword(
            letOrVarKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension FunctionDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> FunctionDeclSyntax {
        withFuncKeyword(
            funcKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension ClassDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> ClassDeclSyntax {
        withClassKeyword(
            classKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(
            leadingTrivia ?? .zero
        )
    }
}

extension StructDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> StructDeclSyntax {
        withStructKeyword(
            structKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(
            leadingTrivia ?? .zero
        )
    }
}


extension EnumDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> EnumDeclSyntax {
        withEnumKeyword(
            enumKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(
            leadingTrivia ?? .zero
        )
    }
}


extension ProtocolDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> ProtocolDeclSyntax {
        withProtocolKeyword(
            protocolKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension TypealiasDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> TypealiasDeclSyntax {
        withTypealiasKeyword(
            typealiasKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension SubscriptDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> SubscriptDeclSyntax {
        withSubscriptKeyword(
            subscriptKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension InitializerDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> InitializerDeclSyntax {
        withInitKeyword(
            initKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension AssociatedtypeDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> AssociatedtypeDeclSyntax {
        withAssociatedtypeKeyword(
            associatedtypeKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension OperatorDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> OperatorDeclSyntax {
        withOperatorKeyword(
            operatorKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}

extension PrecedenceGroupDeclSyntax: HasModifierListSyntax {
    func withReplacedScopeModifiers(with modifiers: [DeclModifierSyntax]) -> PrecedenceGroupDeclSyntax {
        withPrecedencegroupKeyword(
            precedencegroupKeyword.withLeadingTrivia(.zero)
        )
        .withAttributes(
            attributes?.withLeadingTrivia(.zero)
        )
        .withModifiers(
            replacingScopeModifiers(with: modifiers)
        )
        .withLeadingTrivia(leadingTrivia ?? .zero)
    }
}
