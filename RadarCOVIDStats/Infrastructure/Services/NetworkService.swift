//
//  NetworkService.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation
import Network

protocol NetworkServiceDelegate: class {
    var isReachable: Bool { get }

    func networkService(_ service: NetworkService, didChangeReachability reachable: Bool)
}

protocol NetworkService {
    var delegate: NetworkServiceDelegate? { get set }
    var isReachable: Bool { get }

    func startMonitoringReachability()
    func stopMonitoringReachability()
}

class NetworkServiceDefault: NetworkService {
    weak var delegate: NetworkServiceDelegate?

    private(set) var isReachable = false

    private let networkMonitor = NWPathMonitor()

    func startMonitoringReachability() {
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isReachable = true
                self.delegate?.networkService(self, didChangeReachability: true)
            } else {
                self.isReachable = false
                self.delegate?.networkService(self, didChangeReachability: false)
            }
        }

        let networkMonitorQueue = DispatchQueue(label: "Network reachability")
        networkMonitor.start(queue: networkMonitorQueue)
    }

    func stopMonitoringReachability() {
        networkMonitor.cancel()
    }
}

