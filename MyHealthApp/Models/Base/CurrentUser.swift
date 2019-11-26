//
//  CurrentUser.swift
//  Gopa
//
//  Created by Santiago Lazzari on 23/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class CurrentUser: NSObject {
    
    static let shared = CurrentUser()
    var user: User?
    var token: Token?
    
    private let tokenKey = "token"
    private let firstTime = "firstTime"
    
    private override init() {
        super.init()
        self.token = getToken()
    }
    
    func setToken(token: Token) {
        self.token = token
        print("token set : \(token)")
        
        UserDefaults.standard.set(token.token, forKey: tokenKey)
        updateHeader(token: token)
    }
    
    func getToken() -> Token? {
        if let token = self.token {
            return token
        }
        
        guard let persistedToken = UserDefaults.standard.string(forKey: tokenKey) else {
            return nil
        }
    
        print("token get : \(String(describing: token?.token))")
        
        return Token(token: persistedToken)
    }
    
    func refreshToken() {
        guard let token = getToken() else  {
            // No tengo token
            return
        }
        
        print("token refresheed : \(token)")
        
        updateHeader(token:token)
    }
    
    private func updateHeader(token: Token?) {
        Headers.token = token
    }
    
    func clear() {
        user = nil
        
        token = nil
        
        UserDefaults.standard.removeObject(forKey: tokenKey)
        
        updateHeader(token: nil)
    }
    
    func enterToApplication() {
        UserDefaults.standard.set(true, forKey: firstTime)
    }
    
    func didEnterForfirstTimeInTheApplication() -> Bool {
        return UserDefaults.standard.bool(forKey: firstTime)
    }
}
