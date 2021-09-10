//
//  NetworkService.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation

protocol Service {
    
}

class NetworkService: Service{
    lazy private var jsonDecoder = JSONDecoder()

    func genericRequest<T: Decodable>(request: Request, callback: @escaping (Result<[T], Error>) -> Void) {
        
        guard let url = buildURL(request: .launchpads) else {
            callback(.failure(NSError(domain: "", code: 2002, userInfo: [:])))
            return
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest){ [jsonDecoder]
            data, response, error in
            if let error = error {
                   callback(.failure(error))
                   return
           }
            guard response != nil, let data = data else {
                    return
            }
            
            if let responseObject = try? jsonDecoder.decode([T].self, from: data) {
                callback(.success(responseObject))
            }
            else {
                let error = NSError(domain: "", code: 2004, userInfo: [:])
                callback(.failure(error))
            }
            
        }
        dataTask.resume()
        
    }
    
    
    private func buildURL(request: Request) -> URL? {
 
        if case let .request(scheme: scheme, host: host, path: path) = request {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            return components.url
        }
        return nil
    }
}

enum Request {
    case request(scheme: String, host: String, path: String)
    
    static let rockets: Request = .request(scheme: "https", host: "api.spacexdata.com", path: "/v4/rockets")
    static let launches: Request = .request(scheme: "https", host: "api.spacexdata.com", path: "/v5/launches")
    static let launchpads: Request = .request(scheme: "https", host: "api.spacexdata.com", path: "/v4/launchpads")
}
