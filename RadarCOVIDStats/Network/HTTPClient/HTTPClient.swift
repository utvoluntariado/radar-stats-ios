//
//  HTTPClient.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

struct Empty: Codable {}

protocol HTTPClient {
    var isConfigured: Bool { get }

    func configure(using configuration: HTTPClientConfiguration)
    func run<ResponseModel: Codable>(request: inout HTTPRequest<ResponseModel>, _ completion: @escaping (Result<ResponseModel, Error>) -> Void)
}

class HTTPClientDefault: NSObject, HTTPClient {
    var isConfigured: Bool { return configuration != nil }

    var session: URLSession! { return URLSession.shared }
    private var configuration: HTTPClientConfiguration?

    func configure(using configuration: HTTPClientConfiguration) {
        self.configuration = configuration
    }

    func run<ResponseModel: Codable>(request: inout HTTPRequest<ResponseModel>, _ completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        guard let configuration = configuration else { completion(Result<ResponseModel, Error>.failure(HTTPClientError.notConfigured)); return }

        request.configure(baseURL: configuration.baseURL)
        let preparedRequest = request

        guard let urlRequest = request.urlRequest else { completion(Result<ResponseModel, Error>.failure(HTTPClientError.notConfigured)); return }
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let urlResponse = response as? HTTPURLResponse else { completion(Result<ResponseModel, Error>.failure(HTTPClientError.invalidResponse)); return }
            self.didCompleteDataTask(response: urlResponse, request: preparedRequest, data: data, error: error, completion: completion)

            // Errors here can be differentiated if at some point in the future they are typed by code from the server
            // switch urlResponse.statusCode {
            // case 200..<226:
            // case 400..<451:
            // case 500..<511:
            // default:
            // }
        })

        task.resume()
    }

    private func didCompleteDataTask<ResponseModel: Codable>(response: HTTPURLResponse, request: HTTPRequest<ResponseModel>, data: Data?, error: Error?, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        var notificationObject: [String: Any] = ["response": response]
        if let urlRequest = request.urlRequest { notificationObject["request"] = urlRequest }
        if let responseData = data { notificationObject["data"] = responseData }
        if let responseError = error { notificationObject["error"] = responseError }

        if let error = error {
            didFail(withError: error, completion: completion)
        } else if let data = data {
            didSuccess(withData: data, request: request, completion: completion)
        } else {
            didFail(withError: HTTPClientError.unknown, completion: completion)
        }
    }

    private func didFail<ResponseModel: Codable>(withError error: Error, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        completion(Result<ResponseModel, Error>.failure(error))
    }

    private func didSuccess<ResponseModel: Codable>(withData data: Data, request: HTTPRequest<ResponseModel>, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        do {
            if request is HTTPRequest<Empty> {
                completion(Result<ResponseModel, Error>.success(Empty() as! ResponseModel))
            } else {
                let expectedModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(Result<ResponseModel, Error>.success(expectedModel))
            }
        } catch {
            completion(Result<ResponseModel, Error>.failure(error))
        }
    }
}