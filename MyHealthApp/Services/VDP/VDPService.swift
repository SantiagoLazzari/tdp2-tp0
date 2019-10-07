//
//  VDPService.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol VDPService {
    func send(authorization: Authorization, success: @escaping () -> Void, failure: @escaping ServiceFailure)
}

class VDPRemoteService: VDPService {

    func send(authorization: Authorization, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
//        let headers = [
//            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
//            "Content-Type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache",
//            "Postman-Token": "7b3d546f-7c6a-4e7a-837a-9b7a3f803da8"
//        ]
//        let parameters = [
//            [
//                "name": "provider_id",
//                "value": "1"
//            ],
//            [
//                "name": "specialty_id",
//                "value": "1"
//            ],
//            [
//                "name": "image",
//                "fileName": "/Users/slazzari/Downloads/Untitled Diagram (2).png"
//            ]
//        ]
//
//        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
//
//        var body = ""
//        var error: NSError? = nil
//        for param in parameters {
//            let paramName = param["name"]!
//            body += "--\(boundary)\r\n"
//            body += "Content-Disposition:form-data; name=\"\(paramName)\""
//            if let filename = param["fileName"] {
//                let contentType = param["content-type"]!
//                let fileContent = String(contentsOfFile: filename, encoding: String.Encoding.utf8)
//                if (error != nil) {
//                    print(error)
//                }
//                body += "; filename=\"\(filename)\"\r\n"
//                body += "Content-Type: \(contentType)\r\n\r\n"
//                body += fileContent
//            } else if let paramValue = param["value"] {
//                body += "\r\n\r\n\(paramValue)"
//            }
//        }
//
//        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:3000/authorizations")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = postData as Data
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//
//        dataTask.resume()
    }
}
