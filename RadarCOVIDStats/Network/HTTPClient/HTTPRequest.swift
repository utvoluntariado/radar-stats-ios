//
//  HTTPRequest.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on24/09/2020.
//

import Foundation

struct HTTPRequest<ResponseModel: Codable> {
    private(set) var parameters: [String: Any]
    private(set) var headers = [String: String]()
    private(set) var endpoint: HTTPEndpoint
    let id: UUID
    var url: URL?
    var baseURL: URL?
    var urlRequest: URLRequest?

    init(endpoint: HTTPEndpoint, parameters: [String: Any]? = nil) {
        self.endpoint = endpoint
        self.parameters = parameters ?? [:]
        id = UUID()
    }

    mutating func configure(baseURL: URL) {
        self.baseURL = baseURL
        url = baseURL.appendingPathComponent(endpoint.address)
        prepareRequest()
        prepareParameters()
    }

    private mutating func prepareRequest() {
        guard let baseURL = baseURL else { return }
        urlRequest = URLRequest(url: baseURL.appendingPathComponent(endpoint.address))
        urlRequest?.httpMethod = endpoint.method.rawValue
        let allHeaders = headers.merging(defaultHTTPHeaders()) { (_, new) in new }
        urlRequest?.allHTTPHeaderFields = allHeaders
    }

    private mutating func prepareParameters() {
        switch endpoint.method {
        case .GET, .DELETE:
            guard let requestURL = url else { return }
            guard var paramsURL = URLComponents(string: requestURL.absoluteString) else { return }
            paramsURL.queryItems = []
            parameters.forEach({ paramsURL.queryItems?.append(URLQueryItem(name: $0.key, value: "\($0.value)")) })
            urlRequest = URLRequest(url: paramsURL.url!)

        case .POST, .PUT:
            let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest?.httpBody = postData
        }
    }

    private func defaultHTTPHeaders() -> [String: String] {
        return [:]
    }
}
