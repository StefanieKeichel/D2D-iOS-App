//
//  ChatViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 18.10.21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        title = Constants.appName
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
    
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (QuerySnapshot, error) in
                
            self.messages = []
            
            if let e = error {
                print("There's an issue retrieving data from firestore. \(e)")
            } else {
                if let snapshopDocuments =  QuerySnapshot?.documents {
                    for doc in snapshopDocuments {
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String,
                           let messageBody = data[Constants.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text{
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField:"x",
                                                                              Constants.FStore.bodyField:messageBody,
                                                                              Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("Something wrong happened, \(e)")
                } else{
                    print("Data was saved successfully.")
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        // The text of the messaged is assigned for every value in the in the messages text in order.
        cell.messageLabel.text = messages[indexPath.row].body
        
        return cell
    }
    
}
