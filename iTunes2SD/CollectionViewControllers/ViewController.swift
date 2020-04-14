//
//  ViewController.swift
//  iTunes2SD
//
//  Created by Slawa on 11.04.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    // MARK: - Main views
    @IBOutlet weak var v_playlistTableView: NSTableView!
    @IBOutlet weak var v_artistTableView: NSTableView!
    @IBOutlet weak var v_albumTableView: NSTableView!
    
    // MARK: - Destination
    @IBOutlet weak var b_folderButton: NSButton!
    @IBOutlet weak var b_phoneButton: NSButton!
    @IBOutlet weak var v_folderTab: NSView!
    @IBOutlet weak var v_phoneTab: NSView!
    @IBOutlet weak var v_sourceTabbedView: NSTabView!
    
    @IBOutlet weak var v_darkenerBehindSourceSelection: NSView!
    
    @IBOutlet weak var i_folderDestination: NSTextField!
    
    // MARK: - Option View
    @IBOutlet weak var b_useExtendedPlaylistFormat: NSButton!
    @IBOutlet weak var b_onlyExportPlaylists: NSButton!
    @IBOutlet weak var b_removeSongsNotInPlaylist: NSButton!
    
    @IBOutlet weak var b_playlistFormat: NSPopUpButton!
    
    @IBOutlet weak var l_progressBar: NSProgressIndicator!
    
    var changeObservers: [NSObjectProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        v_playlistTableView.delegate = v_playlistTableView as? NSTableViewDelegate
        v_playlistTableView.dataSource = v_playlistTableView as? NSTableViewDataSource
        
        v_artistTableView.delegate = v_artistTableView as? NSTableViewDelegate
        v_artistTableView.dataSource = v_artistTableView as? NSTableViewDataSource
        
        v_albumTableView.delegate = v_albumTableView as? NSTableViewDelegate
        v_albumTableView.dataSource = v_albumTableView as? NSTableViewDataSource
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedFolderSource(_ sender: NSButton) {
        if( sender.identifier?.rawValue == "folderButton" ) {
            v_sourceTabbedView.selectTabViewItem(at: 0)
            b_folderButton.image = NSImage(named: NSImage.Name("bFolderSelected"))
            b_phoneButton.image = NSImage(named: NSImage.Name("bPhoneNormal"))
        } else if (sender.identifier?.rawValue == "phoneButton" ) {
            v_sourceTabbedView.selectTabViewItem(at: 1)
            b_folderButton.image = NSImage(named: NSImage.Name("bFolderNormal"))
            b_phoneButton.image = NSImage(named: NSImage.Name("bPhoneSelected"))
        }
    }
    
    func initialSetup() {
        b_folderButton.image = v_sourceTabbedView.indexOfTabViewItem(v_sourceTabbedView.selectedTabViewItem!) == 0 ? NSImage(named: NSImage.Name("bFolderSelected")) : NSImage(named: NSImage.Name("bFolderNormal"))
        b_phoneButton.image = v_sourceTabbedView.indexOfTabViewItem(v_sourceTabbedView.selectedTabViewItem!) == 1 ? NSImage(named: NSImage.Name("bPhoneSelected")) : NSImage(named: NSImage.Name("bPhoneNormal"))
        
        b_useExtendedPlaylistFormat.state = UserPreferences.useExtendedPlaylistFormat ? .on : .off
        b_onlyExportPlaylists.state = UserPreferences.onlyExportPlaylists ? .on : .off
        b_removeSongsNotInPlaylist.state = UserPreferences.removeSongsNotInPlaylist ? .on : .off
        
        i_folderDestination.stringValue = UserPreferences.folderDestination
        
        switch(UserPreferences.playlistFormat) {
            case .m3u:
                b_playlistFormat.selectItem(withTitle: "m3u")
            case .m3u8:
                b_playlistFormat.selectItem(withTitle: "m3u8")
        }
    }
    
    override func viewDidLayout() {
        initialSetup()
        
        v_darkenerBehindSourceSelection.layer?.backgroundColor = NSColor(named: NSColor.Name("cBackgroundPrimary"))!.cgColor
        v_folderTab.layer?.backgroundColor = NSColor(named: NSColor.Name("cBackgroundLight"))!.cgColor
        v_phoneTab.layer?.backgroundColor = NSColor(named: NSColor.Name("cBackgroundLight"))!.cgColor

    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func insertedDestination(_ sender: NSTextField) {
        if sender.stringValue != "" {
            UserPreferences.folderDestination = sender.stringValue
        }
    }
    
    @IBAction func chooseDestinationClicked(_ sender: NSButton) {
        let panel = NSOpenPanel()
        panel.showsResizeIndicator = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        if ( panel.runModal() == NSApplication.ModalResponse.OK ) {
            if let result = panel.url {
                i_folderDestination.stringValue = result.path
                UserPreferences.folderDestination = result.path
            }
        } else {
            return
        }
    }
    
    //MARK: - Opttion Handler
    @IBAction func useExtendedPlaylistFormatClicked(_ sender: NSButton) {
        UserPreferences.useExtendedPlaylistFormat = sender.state == .on
    }
    
    @IBAction func onlyExportPlaylistsClicked(_ sender: NSButton) {
        UserPreferences.onlyExportPlaylists = sender.state == .on
    }
    
    @IBAction func removeSongsNotInPlaylistsClicked(_ sender: NSButton) {
        UserPreferences.removeSongsNotInPlaylist = sender.state == .on
    }
    
    @IBAction func playistFormatSelected(_ sender: NSPopUpButton) {
        switch(sender.selectedItem?.title) {
            case "m3u":
                UserPreferences.playlistFormat = .m3u
            case "m3u8":
                UserPreferences.playlistFormat = .m3u8
            default:
                UserPreferences.playlistFormat = .m3u
        }
    }
    
    @IBAction func syncClicked(_ sender: Any) {
        sync()
    }
    
    func resetSlider(value: Double) {
        l_progressBar.maxValue = value
        l_progressBar.doubleValue = 0
    }
    
    func addNotificationObservers() {
        changeObservers.append(
            NotificationCenter.observe(name: .ItemCopied) {
                if(self.l_progressBar.doubleValue < self.l_progressBar.maxValue) {
                    self.l_progressBar.increment(by: 1.0)
                    print("\(self.l_progressBar.doubleValue) \\ \(self.l_progressBar.maxValue)")
                }
            }
        )
    }
    
    func removeNotificationOberservers() {
        for observer in changeObservers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func sync() {
        if MusicLibraryHelper.shared.reloadData() {
            var selectedPlaylists:[String] = []
            for index in 0..<v_playlistTableView.numberOfRows {
                let view = v_playlistTableView.view(atColumn: 0, row: index, makeIfNecessary: false) as! CheckboxListItem
                
                if view.b_playlistCheck.state == .on {
                    selectedPlaylists.append(view.b_playlistCheck.title)
                }
            }
            
            let selectedPlaylistArray = MusicLibraryHelper.shared.getAllPlaylists().filter {
                selectedPlaylists.contains($0.name)
            }
            
            // Reset the slider
            var sliderMaxWidth: Double = 0
            for playlist in selectedPlaylistArray {
                sliderMaxWidth += Double(playlist.items.count)
            }
            resetSlider(value: sliderMaxWidth)
            
            addNotificationObservers()
            
            FileHelper.shared.sync(fromPlaylists: selectedPlaylistArray, skipCopy: UserPreferences.onlyExportPlaylists)
            
            removeNotificationOberservers()
        }
    }
}

