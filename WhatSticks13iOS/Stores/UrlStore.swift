//
//  UrlStore.swift
//  WS11iOS_v08
//
//  Created by Nick Rodriguez on 31/01/2024.
//

import UIKit

enum APIBase:String, CaseIterable {
    case local = "localhost"
    case dev_10 = "dev_10"
    case dev = "dev"
    case prod_10 = "prod_10"
    case prod = "prod"
    var urlString:String {
        switch self{
        case .local: return "http://127.0.0.1:5001/"
        case .dev_10: return "https://dev.api10.what-sticks.com/"
        case .dev: return "https://dev.api11.what-sticks.com/"
        case .prod_10: return "https://api10.what-sticks.com/"
        case .prod: return "https://api11.what-sticks.com/"
        }
    }
}

enum EndPoint: String {
    case are_we_running = "are_we_running"
    case login = "login"
    case login_generic_account = "login_generic_account"
    case register_generic_account = "register_generic_account"
    case convert_generic_account_to_custom_account = "convert_generic_account_to_custom_account"
    case delete_user = "delete_user"

    case get_reset_password_token = "get_reset_password_token"

}

class URLStore {

    var apiBase:APIBase!

    func callEndpoint(endPoint: EndPoint) -> URL{
        let baseURLString = apiBase.urlString + endPoint.rawValue
        let components = URLComponents(string:baseURLString)!
        return components.url!
    }
}
