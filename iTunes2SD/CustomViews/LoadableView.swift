//
//  LoadableView.swift
//  TableDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Cocoa

protocol LoadableView: class {
    var v_mainView: NSView? { get set }
    func load(fromNIBNamed nibName: String) -> Bool
}


extension LoadableView where Self: NSView {
    func load(fromNIBNamed nibName: String) -> Bool {
        var nibObjects: NSArray?
        let nibName = NSNib.Name(stringLiteral: nibName)
        
        if Bundle.main.loadNibNamed(nibName, owner: self, topLevelObjects: &nibObjects) {
            guard let nibObjects = nibObjects else { return false }
            
            let viewObjects = nibObjects.filter { $0 is NSView }
            
            if viewObjects.count > 0 {
                guard let view = viewObjects[0] as? NSView else { return false }
                v_mainView = view
                self.addSubview(v_mainView!)
                
                v_mainView?.translatesAutoresizingMaskIntoConstraints = false
                v_mainView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                v_mainView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                v_mainView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                v_mainView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                
                return true
            }
        }
        
        return false
    }
    
}
