//
//  BaseService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 02/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

enum HttpErrorType {
    case unauthorized
    case unprocessableEntity
    case other
}

struct HttpError: Error {
    let type: HttpErrorType
}

typealias ServiceFailure = (HttpError) -> Void
typealias ServiceSuccess<Element> = (Element) -> Void

// http://54.85.4.200/atms/?range=500&lat=-34.5879346&long=-58.3831004
// /banks?network=link
// /networks
enum Path:String {
    case base = "http://54.85.4.200/"
    case atms = "atms/"
    case banks = "banks/"
    case networks = "networks/"
}

class Headers {
    
    static func get() -> Dictionary<String,String> {
        var headers = [
            "Content-Type": "application/json",
            ]

        return headers
    }
}

class Service: NSObject {}

extension Service {
    func get<Response:Decodable>(path: String,success: @escaping ServiceSuccess<Response>, failure: @escaping ServiceFailure) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Headers.get()
        call(request: request as URLRequest, success: success, failure: failure)
    }
}

extension Service {
    func post<Request:Encodable, Response:Decodable>(path: String, body: Request, success: @escaping ServiceSuccess<Response>, failure: @escaping ServiceFailure) {
        let body = try! JSONEncoder().encode(body)
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Headers.get()
        request.httpBody = body
        
        call(request: request as URLRequest, success: success, failure: failure)
    }
}

extension Service {
    func put<Request:Encodable, Response:Decodable>(path: String, body: Request, success: @escaping ServiceSuccess<Response>, failure: @escaping ServiceFailure) {
        let body = try! JSONEncoder().encode(body)
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = Headers.get()
        request.httpBody = body
        
        call(request: request as URLRequest, success: success, failure: failure)
    }
}

extension Service {
    func delete<Request:Encodable, Response:Decodable>(path: String, body: Request, success: @escaping ServiceSuccess<Response>, failure: @escaping ServiceFailure) {
        let body = try! JSONEncoder().encode(body)
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = Headers.get()
        request.httpBody = body
        
        call(request: request as URLRequest, success: success, failure: failure)
    }
}

// Api Call
extension Service {
    func call<Response:Decodable>(request: URLRequest, success: @escaping ServiceSuccess<Response>, failure: @escaping ServiceFailure) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                DispatchQueue.main.async {
                    failure(HttpError(type: .other))
                }
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 300 {
                    
                    DispatchQueue.main.sync {
                        switch httpResponse.statusCode {
                        case 401: failure(HttpError(type: .unauthorized)); break
                        case 422: failure(HttpError(type: .unprocessableEntity)); break
                        default: failure(HttpError(type: .other))
                        }
                    }
                    return
                }
                
                let response = try! JSONDecoder().decode(Response.self, from: data!)
                DispatchQueue.main.sync {
                    success(response)
                }
            }
        })
        
        dataTask.resume()
    }
}
