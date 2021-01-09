//
//  ViewController.swift
//  SwiftDIHelper
//
//  Created by Kazuhiro Hayashi on 2021/01/02.
//

import Cocoa



class ViewController: NSViewController {
    @IBOutlet weak var onlyTopLevelCheckButton: NSButton!
    
    var targetStates = [Target: Bool].default
    let userDefaults = UserDefaults.appGroups
    
    @IBOutlet weak var classTargetButton: NSButton!
    @IBOutlet weak var structTargetButton: NSButton!
    @IBOutlet weak var enumTargetButton: NSButton!
    @IBOutlet weak var protocolTargetButton: NSButton!
    @IBOutlet weak var extensionTargetButton: NSButton!
    
    @IBOutlet weak var variableTargetButton: NSButton!
    @IBOutlet weak var functionTargetButton: NSButton!
    @IBOutlet weak var initTargetButton: NSButton!
    @IBOutlet weak var subscriptTargetButton: NSButton!

    @IBOutlet weak var typealiasButton: NSButton!
    @IBOutlet weak var associatedTypeButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onlyTopLevelCheckButton.state = NSButton.StateValue(
            isOn: userDefaults.bool(forKey: UserDefaults.disabledNestedDecl)
        )
        
        
        if let targetStates = userDefaults.value(forKey: UserDefaults.targetStatesKey) as? [String: Bool] {
            self.targetStates = .make(targetStates)
        } else {
            userDefaults.setValue(
                targetStates.export(),
                forKey: UserDefaults.targetStatesKey)
        }
        
        configure()
    }
    
    private func configure() {
        classTargetButton.state = .init(isOn: targetStates[.class]!)
        structTargetButton.state = .init(isOn: targetStates[.struct]!)
        enumTargetButton.state = .init(isOn: targetStates[.enum]!)
        protocolTargetButton.state = .init(isOn: targetStates[.protocol]!)
        extensionTargetButton.state = .init(isOn: targetStates[.extension]!)
        variableTargetButton.state = .init(isOn: targetStates[.variable]!)
        functionTargetButton.state = .init(isOn: targetStates[.function]!)
        initTargetButton.state = .init(isOn: targetStates[.`init`]!)
        subscriptTargetButton.state = .init(isOn: targetStates[.`subscript`]!)
        typealiasButton.state = .init(isOn: targetStates[.typealias]!)
        associatedTypeButton.state = .init(isOn: targetStates[.associatedtype]!)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func enableNestedCheckmarkActionSent(_ sender: NSButton) {
        switch sender.state {
        case .off:
            userDefaults.set(true, forKey: UserDefaults.disabledNestedDecl)
        case .on:
            userDefaults.set(false, forKey: UserDefaults.disabledNestedDecl)
        case .mixed:
            break
        default:
            break
        }
    }
    
    @IBAction func TargetCheckBoxiesSentAction(_ sender: NSButton) {
        guard let target = Target(rawValue: sender.tag) else {
            return
        }
        
        targetStates[target] = sender.isOn
        
        
        userDefaults.set(targetStates.export(), forKey: UserDefaults.targetStatesKey)
    }
}

extension NSButton {
    var isOn: Bool? {
        switch state {
        case .on:
            return true
        case .off:
            return false
        case .mixed:
            return nil
        default:
            return nil
        }
    }
}

extension NSControl.StateValue {
    init(isOn: Bool) {
        if isOn {
            self = .on
        } else {
            self = .off
        }
    }
}
