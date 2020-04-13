//
//  MusicLibraryHelper.swift
//  iTunes2SD
//
//  Created by Slawa on 12.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa
import iTunesLibrary

class MusicLibraryHelper {
    static let shared = MusicLibraryHelper()
    
    let iTunesLibrary: ITLibrary?
    
    init() {
        do {
            iTunesLibrary = try ITLibrary(apiVersion: "1.0")
        } catch {
            print(error.localizedDescription)
            iTunesLibrary = nil
        }
    }
    
    func getAllPlaylists() -> [ITLibPlaylist] {
        return iTunesLibrary?.allPlaylists ?? []
    }
    
    func reloadData() -> Bool {
        return iTunesLibrary?.reloadData() ?? false
    }
    
    func getAllAlbums() -> [String] {
        let allMediaFiles:[ITLibMediaItem] = iTunesLibrary?.allMediaItems ?? []
        var allAlbums:[String] = []
        for track in allMediaFiles {
            guard let album = track.album.title else {
                continue
            }
            
            if album != "" {
                allAlbums.append(album)
            }
        }
        
        return Array(Set(allAlbums)).sorted()
    }
    
    func getAllArtists() -> [String] {
        let allMediaFiles:[ITLibMediaItem] = iTunesLibrary?.allMediaItems ?? []
        var allArtists:[String] = []
        for track in allMediaFiles {
            guard let artist = track.artist?.name else {
                continue
            }
            
            if artist != "" {
                allArtists.append(artist)
            }
        }
        
        
//        allArtistsArray.sort {
//            $0.name ?? "" < $1.name ?? ""
//        }
        
        return Array(Set(allArtists)).sorted()
    }
}
