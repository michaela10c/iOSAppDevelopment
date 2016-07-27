//
//  Fetcher.swift
//  Lecture10InClass
//
//  Created by Michael Zhou on 7/25/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation


class Fetcher: NSObject, NSURLSessionTaskDelegate{
    
    func session() -> NSURLSession{
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15.0
        return NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    //MARK: NSURLSessionDelegate
    
    //Spawn off task from internet, multithreading
    
    //When complete, I just completed. Here, dismiss progress bar
    
    
    //MARK: NSURLSessionTaskDelegate
    
    //
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
    }
    
   
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    //In EMERGENCY, handle completion -> "I'm DONE with loading these bits (e.g. JSON file)!!!!!!"
     typealias RequestCompletionHandler = (data: NSData?, message: String?) -> Void
    func request(url: NSURL, completion: RequestCompletionHandler){
        _ = session().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            let message = self.parseResponse(response, error: error)
            completion(data: data, message: message)
            
        }
        
    }
    
    
    //call from VC
    typealias JSONRequestCompletionHandler = (json:NSObject?, message: String?) -> Void
    func requestJSON(url: NSURL, completion: JSONRequestCompletionHandler){
        request(url) { (data, message) in
            var json: NSObject?
            if let data = data{//if data filled in... take the optional off of it
               
                //Parse the Strings as JSON strings!
                json = try? NSJSONSerialization.JSONObjectWithData(data,
                                                                   options: NSJSONReadingOptions.AllowFragments) as! NSObject
            }
            completion(json: json, message: message)
        }
    }
    
    func parseResponse(response: NSURLResponse?, error: NSError?) -> String? {
        if let statusCode = (response as? NSHTTPURLResponse)?.statusCode{
            if statusCode == 200{
                return nil
            }
            else{
                return "HTTP Error \(statusCode): \(NSHTTPURLResponse.localizedStringForStatusCode(statusCode))"
            }
        }
        else{
            if let netErr = error{
                return "Network Error: \(netErr.localizedDescription)"
            } else {
                return "OS Error: network error was empty"
            }
        }
    }
    
}

extension Fetcher: NSURLSessionDelegate{
    
    //Error
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?){
        NSLog("\(#function): Session became invalid: \(error?.localizedDescription)")
    }
    
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession){
        
    }
    
    //Authentication - mostly in facebook, twitter, .....
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
    }
    
}
