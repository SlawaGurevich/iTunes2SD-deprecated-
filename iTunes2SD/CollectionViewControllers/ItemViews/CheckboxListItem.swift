//
//  CheckboxListItem.swift
//  iTunes2SD
//
//  Created by Slawa on 13.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class CheckboxListItem: NSView, LoadableView {
    @IBOutlet weak var b_playlistCheck: NSButton!
    @IBOutlet weak var i_itemCounter: NSTextField!

    var v_mainView: NSView?
    
    init() {
        super.init(frame: NSRect.zero)
        _ = load(fromNIBNamed: "CheckboxListItem")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
