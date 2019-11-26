//
//  VDPService.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

import Alamofire

protocol VDPService {
    func send(authorization: AuthorizationPost, success: @escaping () -> Void, failure: @escaping ServiceFailure)
}

class VDPRemoteService: VDPService {

    func send(authorization: AuthorizationPost, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        requestWith(endUrl: "", imageData: authorization.image?.pngData(), parameters: ["provider_id" : authorization.healthProvider.id, "specialty_id" : authorization.specialty.id, "study_type_id" : authorization.studyType.id, "requester_id" : authorization.requesterId], onCompletion: success, onError: { (error) in
            failure(HttpError(type: .other))
        })
    }
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = Path.base.rawValue + Path.authorizations.rawValue
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + CurrentUser.shared.token!.token,
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData {
                multipartFormData.append(data, withName: "requester_image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?()
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }


}
