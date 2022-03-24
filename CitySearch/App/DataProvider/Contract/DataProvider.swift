//
//  DataProvider.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

protocol DataProviderProtocol {
    static func sharedInstance() -> DataProviderProtocol
    func taskForGETMethod(_ url: URL, parameters: [String:Any]?, completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask?
    func getCities(response: @escaping (_ result: [City]?, _ error : Error?) -> Void)
}

// MARK: - DataProvider: NSObject
class DataProvider : DataProviderProtocol {
    
    // shared session
    var session = URLSession.shared
    
    // MARK: Shared Instance
    class func sharedInstance() -> DataProviderProtocol {
        struct Singleton {
            static var sharedInstance = DataProvider()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: GET
    func taskForGETMethod(_ url: URL, parameters: [String:Any]? = nil, completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask? {
        
        /* Set the parameters */
        _ = parameters
        
        /* Build the URL, Configure the request */
        var urlComponent = URLComponents()
        urlComponent.scheme = url.scheme
        urlComponent.host = url.host
        urlComponent.path = url.path
        var queryItems = [URLQueryItem]()
        parameters?.forEach({ (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value as? String))
        })
        
        urlComponent.queryItems = queryItems
        
        guard let finalURL = urlComponent.url else {
            let userInfo = [NSLocalizedDescriptionKey : "bad request"]
            completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            return nil
        }
        
        /* Make the request */
        let task = session.dataTask(with: finalURL) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            if finalURL.scheme != "file" {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    print(finalURL.scheme!)
                    sendError("Your request returned a status code other than 2xx!")
                    return
                }
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            completionHandlerForGET(data, nil)
            
        }
        
        /* Start the request */
        task.resume()
        
        return task
    }
    
}

