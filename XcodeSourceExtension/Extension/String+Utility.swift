//
//  String+Utility.swift
//  SwiftDIHelperXcodeExtension
//
//  Created by Kazuhiro Hayashi on 2021/01/07.
//

import Foundation

extension String {
    var lines: [String] {
        reduce(into: [""]) { (result, char) in
            var lastLine = result.removeLast()
            if lastLine.last?.isNewline == true {
                result.append(lastLine)
                lastLine = ""
            }
            
            lastLine.append(char)
            result.append(lastLine)
        }
    }
}
