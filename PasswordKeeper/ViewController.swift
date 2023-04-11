//
//  ViewController.swift
//  PasswordKeeper
//
//  Created by Jegor on 11.04.2023.
//

import Foundation
import Cocoa


class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, NSSearchFieldDelegate {
    
    @IBOutlet weak var loginField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var descriptionField: NSTextField!
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!
    
    var passwords: [Password] = []
    var filteredPasswords: [Password] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load passwords from JSON file
        let fileManager = FileManager.default
        let jsonFilePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("passwords.json")
        if let data = try? Data(contentsOf: jsonFilePath) {
            let decoder = JSONDecoder()
            passwords = try! decoder.decode([Password].self, from: data)
            filteredPasswords = passwords
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        // Save passwords to JSON file
        let fileManager = FileManager.default
        let jsonFilePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("passwords.json")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(passwords)
        try! data.write(to: jsonFilePath)
    }
    
    @IBAction func addPassword(_ sender: Any) {
        let login = loginField.stringValue
        let password = passwordField.stringValue
        let description = descriptionField.stringValue
        
        let newPassword = Password(login: login, password: password, description: description)
        passwords.append(newPassword)
        filteredPasswords = passwords
        tableView.reloadData()
        
        loginField.stringValue = ""
        passwordField.stringValue = ""
        descriptionField.stringValue = ""
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filteredPasswords.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let password = filteredPasswords[row]
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PasswordCell"), owner: nil) as? NSTableCellView {
            if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "LoginColumn") {
                cell.textField?.stringValue = password.login
            } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DescriptionColumn") {
                cell.textField?.stringValue = password.description
            }
            return cell
        }
        return nil
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let searchField = obj.object as? NSSearchField {
            search(searchField.stringValue)
        }
    }
    
    func search(_ searchText: String) {
        if searchText.isEmpty {
            filteredPasswords = passwords
        } else {
            filteredPasswords = passwords.filter { $0.login.contains(searchText) || $0.description.contains(searchText) }
        }
        tableView.reloadData()
    }
}
