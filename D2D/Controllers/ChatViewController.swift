import UIKit
import Firebase
import MultipeerConnectivity
import AVFoundation

class ChatViewController: UIViewController, MCSessionDelegate,  MCNearbyServiceAdvertiserDelegate, MCBrowserViewControllerDelegate{
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var send_button: UIButton!
    @IBOutlet weak var connectionButton: UIBarButtonItem!
    
//    let db = Firestore.firestore()
    let systemSoundID: SystemSoundID = 1322
    
    var User_Name = ""
    var voicemessage = ""
    var sendmessage = ""
    var receivedMessage = ""
    
    var hosting: Bool!
    var peerID: MCPeerID!
    var mcSession: MCSession!

    var MCNearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        AudioServicesPlaySystemSound(systemSoundID)
        
        peerID = MCPeerID(displayName: User_Name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
//        at initalization
        if voicemessage != "" {
            delayWithSeconds(5) {}
            send_button.sendActions(for: .touchUpInside)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        hosting = false
        mcSession.disconnect()
        chatTextView.isEditable = false
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 123/255, green: 32/255, blue: 233/255, alpha: 1.0)
        
    }
    
    @objc func hideKeyboard() {
            view.endEditing(true)
        DispatchQueue.main.async {
        }
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

    @IBAction func dismiss_keyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func connectionButtonTapped(_ sender: Any) {
        if mcSession.connectedPeers.count == 0 && !hosting
        {
            let connectActionSheet = UIAlertController(title: "Our chat", message: "Do you want to host or join a chat?", preferredStyle: .actionSheet)
            connectActionSheet.addAction(UIAlertAction(title: "Host chat", style: .default, handler: { [self](action:UIAlertAction) in
                
                self.MCNearbyServiceAdvertiser = MultipeerConnectivity.MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "chat")
                self.MCNearbyServiceAdvertiser.delegate = self
                self.MCNearbyServiceAdvertiser.startAdvertisingPeer()
                self.hosting = true
            }))
            
            connectActionSheet.addAction(UIAlertAction(title: "Join chat", style: .default, handler: {(action:UIAlertAction) in
                let mcBrowser = MCBrowserViewController(serviceType: "chat", session: self.mcSession)
                mcBrowser.delegate = self
                self.present(mcBrowser, animated: true, completion: nil)
            }))
            
            connectActionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            self.present(connectActionSheet, animated: true, completion: nil)
        }
        else if mcSession.connectedPeers.count == 0 && hosting
        {
            let waitActionSheet = UIAlertController(title: "Waiting ...", message: "Waiting for others to join the chat", preferredStyle: .actionSheet)
            
            waitActionSheet.addAction(UIAlertAction(title: "Disconnect", style: .destructive, handler: {
                (action) in
                self.mcSession.disconnect()
                self.hosting = false
            }))
            
            waitActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(waitActionSheet, animated: true, completion: nil)
        }
        else
        {
            let disconnectActionSheet = UIAlertController(title: "Are you sure you want to disconnect?", message: nil, preferredStyle: .actionSheet)
            disconnectActionSheet.addAction(UIAlertAction(title: "Disconnect", style: .destructive, handler: { (action:UIAlertAction) in
                self.mcSession.disconnect()
            }))
            disconnectActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(disconnectActionSheet, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
//  Define the message that is going to be send and save it in the variable "sendmessage"
        hideKeyboard()
        if messageTextField.text != "" {
            sendmessage = messageTextField.text!
        }
        else if voicemessage != "" {
            sendmessage = voicemessage
        }else{
            sendmessage = ""
        }
        
        
        if sendmessage != "" {
//            && mcSession.connectedPeers.count > 0 {
            

//            Messgages are not stored
//                db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField:"x",
//                                                                                  Constants.FStore.bodyField: sendmessage,
//                                                                                  Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
//                    if let e = error{
//                        print("Something wrong happened, \(e)")
//                    } else{
//                        print("Data was saved successfully.")
//                    }
//                }
//                NETWORKING
                let message = sendmessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
                do
                {
                    try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
                }
                catch
                {
                    print(error.localizedDescription)
                    print("Error sending message")
                }
                
                chatTextView.text = chatTextView.text + "\n\(peerID.displayName): \(sendmessage)\n"
                messageTextField.text = ""
            }
            else
            {
                let emptyAlert = UIAlertController(title: "You have not entered any text", message: nil, preferredStyle: .alert)
                
                emptyAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(emptyAlert, animated: true, completion: nil)
                
            }
    }
    
    // Multipeer Skeleton
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("connected")
            
        case MCSessionState.connecting:
            print("connecting")
            
        case MCSessionState.notConnected:
            print("not connected")
            
        @unknown default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.receivedMessage = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            self.chatTextView.text = self.chatTextView.text + self.receivedMessage
        }
    }
        
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }

//    Called to validate the client certificate provided by a peer when the connection is first established.
    func session(_ session: MCSession, didReceiveCertificate: [Any]?, fromPeer: MCPeerID, certificateHandler: (Bool) -> Void) {
    }
    
    
    // Browser Methods
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browser(_ browser: MCBrowserViewController, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    }
    
    func browser(_ browser: MCBrowserViewController, lostPeer peerID: MCPeerID) {
    }
    

    // Advertiser Methods
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        
        let ac = UIAlertController(title: "chat", message: "'\(peerID.displayName)' wants to connect", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Accept", style: .default, handler: { [weak self] _ in
                    invitationHandler(true, self?.mcSession)
                }))
                ac.addAction(UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
                    invitationHandler(false, nil)
                }))
                present(ac, animated: true)
    }

}
