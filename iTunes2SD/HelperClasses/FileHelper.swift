//
//  FileHelper.swift
//  iTunes2SD
//
//  Created by Slawa on 13.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation
import iTunesLibrary

class FileHelper {
    static var shared = FileHelper()
    
    func copyPlaylistFiles(playlists: [ITLibPlaylist]) {
        for playlist in playlists {
            for mediaItem in playlist.items {
                guard let location = mediaItem.location, let artist = mediaItem.artist?.name, let album = mediaItem.album.title else {
                    return
                }
                
                let filePath = URL(fileURLWithPath: UserPreferences.folderDestination).appendingPathComponent(artist, isDirectory: true).appendingPathComponent(album, isDirectory: true).appendingPathComponent(location.lastPathComponent, isDirectory: false)

                
                do {
                    if(!FileManager.default.fileExists(atPath: filePath.path)) {
                        try FileManager.default.createDirectory(atPath: filePath.deletingLastPathComponent().path, withIntermediateDirectories: true)
                        try FileManager.default.copyItem(atPath: location.path, toPath: filePath.path)
                    }
                    NotificationCenter.post(name: .ItemCopied)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func createPlaylistFiles(playlists: [ITLibPlaylist]) {
        for playlist in playlists {
            let playlistFileName = "\(playlist.name).\(UserPreferences.playlistFormat)"
            print(playlistFileName)
            let playlistFileLocation = URL(fileURLWithPath: UserPreferences.folderDestination).appendingPathComponent(playlistFileName)
            
            var fileOutput = UserPreferences.useExtendedPlaylistFormat ? "#EXTM3U\n\n" : ""
            
            for track in playlist.items {
                if UserPreferences.useExtendedPlaylistFormat {
                    fileOutput.append("#EXT; \(track.totalTime/1000), \(track.artist?.name ?? "") - \(track.title)\n")
                }
                
                guard let artist = track.artist?.name, let album = track.album.title, let location = track.location else {
                    return
                }
                fileOutput.append("\(artist)/\(album)/\(location.lastPathComponent)\n\n")          
            }
            
            do {
                try fileOutput.write(to: playlistFileLocation, atomically: false, encoding: .utf8)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
