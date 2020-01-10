//
//  AppDelegate.swift
//  Teapot
//
//  Created by John Huang on 12/26/19.
//  Copyright © 2019 John Huang. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        /*
        let statusBar = NSStatusBar.system
        let statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        */
        if let button = statusItem.button {
            //button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.image = NSImage(named:NSImage.Name("teapot"))
            button.action = #selector(onIconClick(_:))
            //button.action = #selector(togglePopover(_:))
        }
        
        //constructMenu()
        //constructWindow()
    }
    
    func constructWindow() {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func printQuote(_ sender: Any?) {
      let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
      let quoteAuthor = "Mark Twain"
      
      print("\(quoteText) — \(quoteAuthor)")
    }
    
    func constructMenu() {
      let menu = NSMenu()

      menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

      statusItem.menu = menu
    }
    
    @objc func onIconClick(_ sender: Any?) {
        showScreensaver(sender: sender)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(AppDelegate.showAlert(_:)), userInfo: nil, repeats: false)
         
            //showAlert(sender: sender)
        //lockScreen3()
        //togglePopover(sender: sender)
    }
    
    @objc func showAlert(_ sender: Any?) {
    //@objc func showAlert(sender: Any?) {
        let alert = NSAlert()
        alert.messageText = "Teapot!"
        alert.informativeText = "A helpful coworker has locked your computer for you. Don't forget to lock your computer if it's being left alone!"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.icon = NSImage(named:NSImage.Name("teapot"))
        alert.runModal()
    }
    
    func showScreensaver(sender: Any?) {
        let task = Process()

        task.launchPath = "/usr/bin/open"
        task.arguments = ["-a", "ScreenSaverEngine"]
        task.launch()
    }
    
    @objc func lockScreen() {
        let sourceRef = CGEventSource(stateID: .combinedSessionState)

        if sourceRef == nil {
            NSLog("FakeKey: No event source")
            return
        }

        let keyDownEvent = CGEvent(keyboardEventSource: sourceRef,
                                   virtualKey: 0x31,
                                   keyDown: true)
        let maskDownRaw = CGEventFlags.maskCommand.rawValue | CGEventFlags.maskShift.rawValue
        let keyDownFlags = CGEventFlags(rawValue: maskDownRaw)
        keyDownEvent?.flags = keyDownFlags
        //keyDownEvent?.flags = .maskCommand | .maskControl
        keyDownEvent?.flags = .maskCommand

        let keyUpEvent = CGEvent(keyboardEventSource: sourceRef,
                                 virtualKey: 0x31,
                                 keyDown: false)
        let maskUpRaw = CGEventFlags.maskCommand.rawValue & ~CGEventFlags.maskShift.rawValue
        let keyUpFlags = CGEventFlags(rawValue: maskUpRaw)
        keyUpEvent?.flags = keyUpFlags
        keyUpEvent?.flags = .maskCommand
        
        keyDownEvent?.post(tap: .cghidEventTap)
        keyUpEvent?.post(tap: .cghidEventTap)
    }
    
    @objc func lockScreen3() {
           let sourceRef = CGEventSource(stateID: .combinedSessionState)

        print("hello1")
           if sourceRef == nil {
            print("WTF")
               NSLog("FakeKey: No event source")
               return
           }
print("hello2")
           let keyDownEvent = CGEvent(keyboardEventSource: sourceRef,
                                      virtualKey: 0x7E,
                                      keyDown: true)
           /*
           let maskRaw = .maskCommand.rawValue | .maskControl.rawValue
           let flags = CGEventFlags(rawValue: maskRaw)
           keyDownEvent?.flags = flags
    */
           keyDownEvent?.flags = .maskControl

           let keyUpEvent = CGEvent(keyboardEventSource: sourceRef,
                                    virtualKey: 0x7E,
                                    keyDown: false)

           keyDownEvent?.post(tap: .cghidEventTap)
           keyUpEvent?.post(tap: .cghidEventTap)
        print("hello3")
       }
    
    @objc func lockScreen2() {
        let sourceRef = CGEventSource(stateID: .combinedSessionState)

        if sourceRef == nil {
            NSLog("FakeKey: No event source")
            return
        }

        let keyDownEvent = CGEvent(keyboardEventSource: sourceRef,
                                   virtualKey: 0x31,
                                   keyDown: true)
        let maskDownRaw = CGEventFlags.maskCommand.rawValue | CGEventFlags.maskShift.rawValue
        let keyDownFlags = CGEventFlags(rawValue: maskDownRaw)
        keyDownEvent?.flags = keyDownFlags
        //keyDownEvent?.flags = .maskCommand | .maskControl
        keyDownEvent?.flags = .maskCommand

        let keyUpEvent = CGEvent(keyboardEventSource: sourceRef,
                                 virtualKey: 0x31,
                                 keyDown: false)
        let maskUpRaw = CGEventFlags.maskCommand.rawValue & ~CGEventFlags.maskShift.rawValue
        let keyUpFlags = CGEventFlags(rawValue: maskUpRaw)
        keyUpEvent?.flags = keyUpFlags
        keyUpEvent?.flags = .maskCommand
        
        keyDownEvent?.post(tap: .cghidEventTap)
        keyUpEvent?.post(tap: .cghidEventTap)
    }
    
    func togglePopover(sender: Any?) {
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
    }

    func showPopover(sender: Any?) {
      if let button = statusItem.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
    }
}

