import Foundation
import Network

// Create a class
// Object that listens to network changes
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
//    queue check the internet connection anytime it changes
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
//    check if device is connected
    public private(set) var isConnected: Bool = false
// Default connectionType is "unknown"
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
//
    private init() {
        monitor = NWPathMonitor()
    }
    
//    start the listening process onto network change events
//    anytime the network changes this function is called
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    
    public  func stopMonitoring() {
        monitor.cancel()
    }
    
    public  func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }
        else{
            connectionType = .unknown
        }
    }
    
}
