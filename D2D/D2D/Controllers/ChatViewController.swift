//
//  ChatViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 18.10.21.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextField!
    
    var messages: [Message] = [
        Message(sender: "Karim", body: "Hey Ahmed, Habeeby"),
        Message(sender: "Ahmed", body: "Hey Karim, Habeeby")
    ]
    
    override func viewDidLoad() {
        tableView.dataSource = self
        title = Constants.appName
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

// Adding a data source protocol that is responsible for populating the tableView
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
//    Asking for UI table view cell that it should display in every raw.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        returns a resuable table-view cell for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as! MessageCell
        
        // The text of the messaged is assigned for every value in the in the messages text in order.
        cell.messageLabel.text = messages[indexPath.row].body
        
        return cell
    }
    
}
