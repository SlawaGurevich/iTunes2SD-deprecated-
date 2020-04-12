//
//  UserPreferences.swift
//  iTunes2SD
//
//  Created by Slawa on 12.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation

class UserPreferences {
    private enum Keys: String {
        case useExtendedPlaylistFormat
        case onlyExportPlaylists
        case removeSongsNotInPlaylist
        case playlistFormat
    }
    
    enum playlistFormats: String {
        case m3u, m3u8
    }
    
    class var playlistFormat: playlistFormats {
        get {
            return self.playlistFormats.init(rawValue: self.readString(fromKey: self.Keys.playlistFormat.rawValue) ?? "" ) ?? self.playlistFormats.m3u
        }
        set {
            self.write(value: newValue.rawValue, toKey: self.Keys.playlistFormat.rawValue)
        }
    }
    
    class var useExtendedPlaylistFormat: Bool {
        get {
            return self.readBool(fromKey: self.Keys.useExtendedPlaylistFormat.rawValue) ?? true
        }
        set {
            self.write(value: newValue, toKey: self.Keys.useExtendedPlaylistFormat  .rawValue)
        }
    }
    
    class var onlyExportPlaylists: Bool {
        get {
            return self.readBool(fromKey: self.Keys.onlyExportPlaylists.rawValue) ?? true
        }
        set {
            self.write(value: newValue, toKey: self.Keys.onlyExportPlaylists.rawValue)
        }
    }
    
    class var removeSongsNotInPlaylist: Bool {
        get {
            return self.readBool(fromKey: self.Keys.removeSongsNotInPlaylist.rawValue) ?? true
        }
        set {
            self.write(value: newValue, toKey: self.Keys.removeSongsNotInPlaylist.rawValue)
        }
    }
    
    // MARK: - Functions
    private static func write(value: Any?, toKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    private static func readString(fromKey key: String) -> String? {
        if !self.has(key: key) {
            return nil
        }
        
        return UserDefaults.standard.string(forKey: key)
    }
    
    private static func readBool(fromKey key: String) -> Bool? {
        if !self.has(key: key) {
            return false
        }
        
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private static func has(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
