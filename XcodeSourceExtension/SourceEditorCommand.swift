//
//  SourceEditorCommand.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/02.
//

import Foundation
import XcodeKit
import SwiftSyntax

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        do {
            let buffer = invocation.buffer
            guard let selections = buffer.selections as? [XCSourceTextRange] else {
                completionHandler(nil)
                return
            }
            
            guard let lines = buffer.lines as? [String] else {
                completionHandler(nil)
                return
            }

            for selection in selections {
                let selectedLines = lines[selection.start.line..<selection.end.line]
                // SwiftSyntax
                
                let sourceFile = try SyntaxParser.parse(source: selectedLines.joined())
                let incremented = AddPublicToKeywords().visit(sourceFile)
                
                let incrementedLines = incremented.description.lines
                
                let selectedRange = NSRange(
                    location: selection.start.line,
                    length: selection.end.line - selection.start.line
                )
                buffer.lines.replaceObjects(
                    in: selectedRange,
                    withObjectsFrom: incrementedLines
                )
            }
        } catch let e {
            print(e)
        }
        
        completionHandler(nil)
    }
}
