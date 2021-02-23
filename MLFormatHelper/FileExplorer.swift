//
//  FileExplorer.swift
//  ToJson
//
//  Created by Choong Han Soong on 22/2/21.
//

import SwiftUI

func openPanel()->String {
    let dialog = NSOpenPanel()

    dialog.title                   = "Choose a file| Our Code World"
    dialog.showsResizeIndicator    = true
    dialog.showsHiddenFiles        = false
    dialog.allowsMultipleSelection = false
    dialog.canChooseDirectories = false

    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url // Pathname of the file

        if (result != nil) {
            let path: String = result!.path
            
            return path
        }
        
    } else {
        // User clicked on "Cancel"
        return ""
    }
    return ""
}
