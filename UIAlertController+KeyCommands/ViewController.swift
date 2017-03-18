//
//  ViewController.swift
//  UIAlertController+KeyCommands
//
//  Created by Louis D'hauwe on 18/03/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBAction func changeBgColor(_ sender: UIBarButtonItem) {
		
		let alert = KeyCommandAlertController(title: "Change background color", message: nil, preferredStyle: .actionSheet)
		
		alert.popoverPresentationController?.barButtonItem = sender
		
		let redShortcut = KeyCommandShortcut(input: "B", modifierFlags: .command)
		let redAction = KeyCommandAlertAction(title: "Blue", style: .default, keyShortcut: redShortcut) { (action) in
			
			self.makeBlue()
		}
		
		let greenShortcut = KeyCommandShortcut(input: "R", modifierFlags: .command)
		let greenAction = KeyCommandAlertAction(title: "Red", style: .default, keyShortcut: greenShortcut) { (action) in
			
			self.makeRed()
		}
		
		let cancelAction = KeyCommandAlertAction(title: "Cancel", style: .cancel)
		
		alert.addAction(redAction)
		alert.addAction(greenAction)
		alert.addAction(cancelAction)
		
		present(alert, animated: true, completion: nil)
		
	}

	func makeBlue() {
		self.view.backgroundColor = UIColor(red: 0.0, green: 0.73, blue: 0.87, alpha: 1.0)
	}
	
	func makeRed() {
		self.view.backgroundColor = UIColor(red: 1.0, green: 0.25, blue: 0.24, alpha: 1.0)
	}

}
