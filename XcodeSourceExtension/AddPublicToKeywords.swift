//
//  AddPublicToKeywords.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/03.
//

import Foundation
import SwiftSyntax

extension DeclSyntaxProtocol {
    var isNotMemberListItem: Bool {
        parent?.is(MemberDeclListItemSyntax.self) == false
    }
}

class AddPublicToKeywords: SyntaxRewriter {
    private let userDefaults = UserDefaults.appGroups
    
    private var states: [Target: Bool] {
        let states = userDefaults
            .value(forKey: UserDefaults.targetStatesKey) as? [String: Bool]
        if let _states = states {
            return .make(_states)
        } else {
            return .default
        }
    }
    
    private var disabledNestedDecl: Bool {
        UserDefaults.appGroups
            .bool(forKey: UserDefaults.disabledNestedDecl)
    }
    
    // Can have public members
    override func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
        if disabledNestedDecl, !node.isNotMemberListItem {
            return DeclSyntax(node)
        }
        
        if states[.class] == false {
            return super.visit(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        return super.visit(decl)
    }
    
    override func visit(_ node: StructDeclSyntax) -> DeclSyntax {
        if disabledNestedDecl, !node.isNotMemberListItem {
            return DeclSyntax(node)
        }
        

        if states[.struct] == false {
            return super.visit(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        return super.visit(decl)
    }
    
    override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
        if disabledNestedDecl, node.isNotMemberListItem {
            return DeclSyntax(node)
        }
        
        if states[.enum] == false {
            return super.visit(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        return super.visit(decl)
    }
    
    // Cannot have public members
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        guard node.enabledToChangingToPublic else {
            return DeclSyntax(node)
        }

        if states[.function] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
                .withReplacedScopeModifiers(
                    with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
                )
        return DeclSyntax(decl)
    }
    
    override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        guard node.enabledToChangingToPublic else {
            return DeclSyntax(node)
        }
        
        if states[.variable] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
                .withReplacedScopeModifiers(
                    with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
                )
        return DeclSyntax(decl)
    }

    override func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
        guard node.enabledToChangingToPublic else {
            return DeclSyntax(node)
        }
        
        if states[.subscript] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        
        return DeclSyntax(decl)
    }
    
    override func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
        guard node.enabledToChangingToPublic else {
            return DeclSyntax(node)
        }
        
        if states[.`init`] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        
        return DeclSyntax(decl)
    }
    
    override func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
        if states[.protocol] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        return DeclSyntax(decl)
    }
    
    override func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
        if states[.typealias] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        
        return DeclSyntax(decl)
    }
    
    
    override func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
        if states[.associatedtype] == false {
            return DeclSyntax(node)
        }
        
        let decl = node
            .withReplacedScopeModifiers(
                with: [SyntaxFactory.makeDeclPublicKeywordModifier()]
            )
        
        return DeclSyntax(decl)
    }
}

extension DeclSyntaxProtocol {
    var enabledToChangingToPublic: Bool {
        let containingDecl = parent?.as(MemberDeclListItemSyntax.self)?
            .parent?.as(MemberDeclListSyntax.self)?
            .parent?.as(MemberDeclBlockSyntax.self)?
            .parent
        
        guard containingDecl != nil else {
            return true
        }
        
        if let decl = containingDecl?.as(ClassDeclSyntax.self) {
            return decl.modifiers?.hasPublic == true
        } else if let decl = containingDecl?.as(StructDeclSyntax.self) {
            return decl.modifiers?.hasPublic == true
        } else if let decl = containingDecl?.as(EnumDeclSyntax.self) {
            return decl.modifiers?.hasPublic == true
        } else {
            return true
        }
    }
}
