//
//  ArtistCollectionViewController.swift
//  iTunes2SD
//
//  Created by Slawa on 12.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class ArtistsTableView: NSTableView {
    
}


extension ArtistsTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let artists = MusicLibraryHelper.shared.getAllArtists()
        guard let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ArtistCell"), owner: self) as? NSTableCellView else { return nil }
        
        cellView.textField?.stringValue = artists[row]
        return cellView
    }
}

extension ArtistsTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MusicLibraryHelper.shared.getAllArtists().count
    }
}
