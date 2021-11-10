//
//  NetworkingViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 10.11.21.
//

import UIKit
import MultipeerConnectivity

class NetworkingViewController: UIViewController {
    
    private let multiPeer: MultipeerSession
    
    init(multiPeer: MultipeerSession){
        
        self.multiPeer = multiPeer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        multiPeer.peerID = MCPeerID(displayName: UIDevice.current.name)
        multiPeer.mcSession = MCSession(peer: multiPeer.peerID, securityIdentity: nil, encryptionPreference: .required)
        multiPeer.mcSession.delegate = self
    }
    
    func startHosting (action: UIAlertAction!){
        multiPeer.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-kb", discoveryInfo: nil, session: MCSession)
        multiPeer.mcAdvertiserAssistant.start()
    }
    
    func joinsession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "hws-kb", session: MCSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }


}

extension NetworkingViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("Not connected \(peerID)")
        case .connecting:
            print("Connecting \(peerID)")
        case .connected:
            print("Connected \(peerID)")
        default: print("Unknown status for \(peerID)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    
    
}

extension NetworkingViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    
}
