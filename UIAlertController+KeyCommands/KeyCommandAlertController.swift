//
//  KeyCommandAlertController.swift
//  UIAlertController+KeyCommands
//
//  Created by Louis D'hauwe on 18/03/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import UIKit

struct KeyCommandShortcut: CustomStringConvertible {
	
	let input: String
	let modifierFlags: UIKeyModifierFlags
	
	var description: String {
		
		var descr = ""
		
		// TODO: complete flag handling
		if modifierFlags.contains(.command) {
			descr += "⌘"
		}
		
		if modifierFlags.contains(.shift) {
			descr += "⇧"
		}
		
		if modifierFlags.contains(.alternate) {
			descr += "⌥"
		}
		
		descr += "\(input)"
		
		return descr
		
	}
	
}

class KeyCommandAlertAction {
	
	let keyShortcut: KeyCommandShortcut?
	var uiKeyCommand: UIKeyCommand?
	let actionHandler: ((UIAlertAction) -> Swift.Void)?
	
	public let alertAction: UIAlertAction
	
	init(title: String?, style: UIAlertActionStyle, keyShortcut: KeyCommandShortcut? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
		
		let displayTitle: String?
		
		if let title = title {
			
			if let keyShortcut = keyShortcut {
				displayTitle = title + " (\(keyShortcut.description))"
			} else {
				displayTitle = title
			}
			
		} else {
			
			displayTitle = nil
			
		}
		
		alertAction = UIAlertAction(title: displayTitle, style: style, handler: handler)
		self.keyShortcut = keyShortcut
		self.actionHandler = handler
	}
	
}

class KeyCommandAlertController: UIAlertController {
	
	private var keyCommandActions = [KeyCommandAlertAction]()
	
	func didActiveKeyCommand(_ sender: UIKeyCommand) {
		print("\(sender)")
		
		for keyCommand in keyCommandActions {
			
			if sender == keyCommand.uiKeyCommand {
				keyCommand.actionHandler?(keyCommand.alertAction)
			}
			
		}
		
		self.dismiss(animated: true, completion: nil)
	}
	
	func addAction(_ action: KeyCommandAlertAction) {
		self.addAction(action.alertAction)
		keyCommandActions.append(action)
	}
	
	override var keyCommands: [UIKeyCommand]? {
		
		var keyCommands = [UIKeyCommand]()
		
		for keyCommand in keyCommandActions {
			
			if let keyShortcut = keyCommand.keyShortcut, let title = keyCommand.alertAction.title {
				
				let keyCmd = UIKeyCommand(input: keyShortcut.input, modifierFlags: keyShortcut.modifierFlags, action: #selector(didActiveKeyCommand(_:)), discoverabilityTitle: title)
				
				keyCommand.uiKeyCommand = keyCmd
				
				keyCommands.append(keyCmd)
				
			}
			
		}
		
		return keyCommands
	}
	
}
