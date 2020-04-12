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
        guard let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PlaylistCell"), owner: self) as? NSTableCellView else { return nil }
        cellView.textField?.stringValue = playlists[row].name
        
        return cellView
    }
}

extension PlaylistsTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        print(MusicLibraryHelper.shared.getAllPlaylists())
        return MusicLibraryHelper.shared.getAllPlaylists().count
    }
}
