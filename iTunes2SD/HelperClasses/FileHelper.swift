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
    
    /**
     Syncs files to the destination folder for playlists.
     
     - Parameter playlists: The playlists to sync.
     - Parameter skipCopy: Whether to only export playlist files.
     */
    func sync(fromPlaylists playlists: [ITLibPlaylist], skipCopy: Bool) {
        for playlist in playlists {
            // PlaylistFiles
            let playlistFileName = "\(playlist.name).\(UserPreferences.playlistFormat)"
            let playlistFileLocation = URL(fileURLWithPath: UserPreferences.folderDestination).appendingPathComponent(playlistFileName)
            
            var fileOutput = UserPreferences.useExtendedPlaylistFormat ? "#EXTM3U\n\n" : ""
            
            for mediaItem in playlist.items {
                // #start create playlist file
                if UserPreferences.useExtendedPlaylistFormat {
                    fileOutput.append("#EXT; \(mediaItem.totalTime/1000), \(mediaItem.artist?.name ?? "") - \(mediaItem.title)\n")
                }
                
                guard let location = mediaItem.location else {
                    return
                }
                
                let album: String = ( mediaItem.album.title == "" ? "Unknown Album" : mediaItem.album.title ) ?? "Unknown Album"
                let artist: String = mediaItem.album.isCompilation ? "Compilations" : (mediaItem.artist?.name ?? "Unknown Artist")
                
                fileOutput.append("./\(artist)/\(album)/\(location.lastPathComponent)\n\n")
                
                do {
                    try fileOutput.write(to: playlistFileLocation, atomically: false, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
                }
                // #end create playlist file
                
                // #start copy files
                if(!skipCopy) {
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
                // #end copy files
            }
        }
    }
}
