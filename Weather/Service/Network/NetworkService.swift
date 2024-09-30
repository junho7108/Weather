//
//  NetworkService.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Alamofire
import Foundation
import Combine

class NetworkService: NSObject {
    static let shared = NetworkService()
    
    private(set) var session: Session
    
    private override init() {
        let apiLogger = APIEventLogger()
        self.session = Session(eventMonitors: [apiLogger])
    }
    
    private var headers: HTTPHeaders {
        return HTTPHeaders.init([
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Accept", value: "application/json")
        ])
    }
    
    func sendGet<T: Decodable>(with url: String,
                               parameters: Parameters? = nil) async -> Result<T, Error> {
        let task = session.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .serializingDecodable(T.self)
        
        let response = await task.response
           
        switch response.result {
        case .success(let model):
            return .success(model)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func sendGet<T: Decodable>(with url: String,
                               parameters: Parameters? = nil,
                               completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .responseDecodable(of: T.self) { res in
                switch res.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

extension NetworkService {
    func sendGet<T: Decodable>(with url: String, parameters: Parameters? = nil) -> AnyPublisher<T, Error> {
        
        session.request(url,
                        method: .get,
                        parameters: parameters,
                        headers: headers)
        .publishDecodable(type: T.self)
        .value()
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}

