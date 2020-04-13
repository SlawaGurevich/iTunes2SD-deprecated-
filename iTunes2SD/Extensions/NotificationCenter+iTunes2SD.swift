//
//  NotificationCenter+iTunes2SD.swift
//  iTunes2SD
//
//  Created by Slawa on 13.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import AppKit

extension NotificationCenter {
    static func post(name: NSNotification.Name) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: nil)
    }
    
    static func observe(name: NSNotification.Name, _ completionHandler: @escaping () -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { _ in
            completionHandler()
        }
    }
}
