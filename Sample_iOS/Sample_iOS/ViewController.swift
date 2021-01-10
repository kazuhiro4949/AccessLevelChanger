//
//  ViewController.swift
//  Sample_iOS
//
//  Created by 林和弘 on 2021/01/10.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func viewControllerDidSelectClose(_ vc: ViewController)
}

class ViewController: UIViewController {
    typealias Label = String
    
    struct Section {
        enum Row {
            case main
            case footer
        }
        
        let rows: [Row]
    }
    
    var section: [Section] = [Section]() {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prop1 = ""
        var prop2 = ""
    }
    
    // MARK:- properties
    private(set) var prop1: String = ""
    var prop2: String = ""
    internal fileprivate(set) var prop3: String = ""
    private var prop4: String = ""
    private private(set) var prop5: String = ""
    internal var prop6: String = ""
    var test3: String {
        set {
            
        }
        get {
            func test() {
                
            }
            let aaa = ""
            print(aaa)
            return ""
        }
    }
    var test4: String! {
        ""
    }
    
    // MARK:- methods
    func func1() {}
    private func func2() {}
    fileprivate func func3() {}
    internal func func4() {}
    func func5() {}
    @IBAction func func6(_ test: Any) {}
    func func7() {
        func func8() {
            func func9() {
                func func10() {}
            }
        }
    }
}

extension ViewController {
    func protocolFunc1() {}
    private func protocolFunc2() {}
    func protocolFunc3() {}
}

struct Struct1 {
    private var prop1: String
    var prop2: String
    
    init() {
        prop1 = ""
        prop2 = ""
    }
    
    func func1() {}
    mutating func func2() {}
}

enum Enum1 {
    case case1
    case case2
    case case3
    
    func fucn1() {}
    
    private var prop1: String {
        ""
    }
}

func func1() {}

var prop1 = ""

protocol Protocol1 {
    func func1()
}

typealias TypeAlias = String


precedencegroup NoAssignmentPrecedence {
    assignment: false
}

infix operator ??=: NoAssignmentPrecedence

func ??=(left: String, right: String) {
    
}

func testfunc2() {
    func testfunc3() {
        var aaa = ""
    }
}
