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
        guard let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AlbumCell"), owner: self) as? NSTableCellView else { return nil }
        
        cellView.textField?.stringValue = albums[row]
        return cellView
    }
}

extension AlbumsTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MusicLibraryHelper.shared.getAllAlbums().count
    }
}
