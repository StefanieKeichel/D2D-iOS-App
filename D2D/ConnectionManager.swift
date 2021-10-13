
import Foundation
import MultipeerConnectivity

//               is the class used to handle all communication between devices.
class JobConnectionManager: NSObject, ObservableObject {
    
//   MCSession is the class used to handle all communication between devices.
    private let session : MCSession
//    MCPeerID identifies your device on the local network. In this example, you’re using the name you set for your phone.

    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let MessageReceivedHandler: MessageReceivedHandler?

    
//    init(peer: MCPeerID, securityIdentity: [Any]?, encryptionPreference: MCEncryptionPreference)
//    Creates a Multipeer Connectivity session, providing security information.
    
    init(_ MessageReceivedHandler: MessageReceivedHandler? = nil) {
//        Initialize your session with your peer ID. You can choose whether you want encryption used for your messages.
        session = MCSession(
            peer: myPeerId,
            securityIdentity: [Any]?,
            encryptionPreference: MCEncryptionPreference)
        self.MessageReceivedHandler = MessageReceivedHandler
        )
    }

    //MCNearbyServiceAdvertiser is the class that will handle making your device discoverable through MCSession
    private static let service = "jobmanager-jobs"
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    //initializer of JobConnectionManager
    
//    initialized nearbyServiceAdvertiser with a Service Type. Multipeer Connectivity uses the service type to limit the way it handles discovering advertised devices. In this project, JobConnectionManager will only be able to discover devices that advertise with the service name of jobmanager-jobs.
    nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
      peer: myPeerId,
      discoveryInfo: nil,
    //  Multipeer Connectivity uses the service type to limit the way it handles discovering advertised devices. In this project, JobConnectionManager will only be able to discover devices that advertise with the service name of jobmanager-jobs.
      serviceType: JobConnectionManager.service)

}


extension JobConnectionManager: MCNearbyServiceAdvertiserDelegate {
  func advertiser(
    _ advertiser: MCNearbyServiceAdvertiser,
    didReceiveInvitationFromPeer peerID: MCPeerID,
    withContext context: Data?,
    invitationHandler: @escaping (Bool, MCSession?) -> Void
  ) {
  }
}

