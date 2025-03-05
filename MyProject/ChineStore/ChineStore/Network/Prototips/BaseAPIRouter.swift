//
//  BaseAPIRouter.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import Foundation
import Alamofire

protocol RouterDataSource: URLRequestConvertible {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queries: Parameters? { get }
    var body: Parameters? { get }
    var headers: [String: String]? { get }
}

extension RouterDataSource {
    var httpMethod: HTTPMethod {
            return .get
        }
        
        var queries: Parameters? {
            return nil
        }
        
        var body: Parameters? {
            return nil
        }
        
        var headers: [String: String]? {
            return nil
        }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try path.asURL())
        request.method = httpMethod
        
        if let headers {
            request.headers = .init(headers)
        }
       
        if let queries {
            //request = try URLEncoding.queryString.encode(request, with: queries)
            request = try URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal).encode(request, with: queries)
           //ArrayEncoding
        }
       
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        return request
    }
    
}
