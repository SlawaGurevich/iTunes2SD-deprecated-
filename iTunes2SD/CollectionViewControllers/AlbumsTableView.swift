//
//  AlbumCollectionViewController.swift
//  iTunes2SD
//
//  Created by Slawa on 12.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class AlbumsTableView: NSTableView {
    
}

extension AlbumsTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let albums = MusicLibraryHelper.shared.getAllAlbums()
        
        let view = CheckboxListItem()
        view.i_itemCounter.isHidden = true
        view.b_playlistCheck.title = albums[row]

        return view
    }
}

extension AlbumsTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MusicLibraryHelper.shared.getAllAlbums().count
    }
}
