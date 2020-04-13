//
//  PlaylistCollectionViewController.swift
//  iTunes2SD
//
//  Created by Slawa on 12.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class PlaylistsTableView: NSTableView {

}

extension PlaylistsTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let playlists = MusicLibraryHelper.shared.getAllPlaylists()
        
        let view = CheckboxListItem()
        view.i_itemCounter.stringValue = "\(playlists[row].items.count)"
        view.b_playlistCheck.title = playlists[row].name

        return view
    }
}

extension PlaylistsTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        print(MusicLibraryHelper.shared.getAllPlaylists())
        return MusicLibraryHelper.shared.getAllPlaylists().count
    }
}
