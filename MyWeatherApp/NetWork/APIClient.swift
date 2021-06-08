//
//  APIClient.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 06/06/21.
//

import Foundation

public typealias HTTPGetRespHandler = (_ response: AnyObject?, _ error: Error?) -> Void
import UIKit
class APIClient : NSObject {
    
    static var shared  = APIClient()

    private var session = URLSession.shared
    
    private var task : URLSessionDataTask?
    override init() {
        super.init()
        session.configuration.timeoutIntervalForRequest = 15
    }
    func cancelPreViousCalls(){
        task?.cancel()
    }
    func taskForGETMethod(url: URL, completionHandlerForGET: @escaping HTTPGetRespHandler) {
       
            let request = URLRequest(url: url)
            
        
             task = session.dataTask(with: request as URLRequest){
                data , response ,error in
                guard  error == nil else{
                    completionHandlerForGET(nil,error)
                    return
                }
                if let data = data{
                    completionHandlerForGET(data as AnyObject,nil)
                }else{
                    completionHandlerForGET(nil,error)
                }
            }
            task?.resume()
        
    }
}
