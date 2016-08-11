//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

// IN THIS LAB, WE ARE DEALING WITH API(GIVE US STUFF GITHUB)  MODEL (BUILD THE MODEL)  AND DATA STORE


//Here, we return nothing because the computer will get back nothing instantly but the closure within this function will work and return when it's ready. completion is not expecting anything immediately "Array -> ()" expects it when it's ready.


//we have to have an URL object so we are casting our string URl to type NSURL in let URL = NSURL(string: urlString) 


class GithubAPIClient {
        
//    class func getRepositoriesWithCompletion(completion:NSArray) -> () {
//        
//        let urlString = "\(Secrets.apiURL)repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
//        let URL = NSURL(string: urlString)
//        
//        //we are starting our session. Shared session is a cart that Julian wheels around for everyone to get books from. CART WITH BOOKS. Returns a shared singleton session object.
//        let session = NSURLSession.sharedSession()
//        
//        //it's going to pass in NSData, NSURLresponse, and NSError and get back nothing. completion handler is the data that's going to come back from the internet. the URL is the URL we have.
    
    class func getRepositoriesWithCompletion(completion: [[String: AnyObject]] -> ()) {
        let urlString = "\(Secrets.apiURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()   //opening up a new browser is a new session
        
        
        //guard lets are opposite than if lets --- create constant
    
        guard let potentialUrl = url else {assertionFailure("Invalid URL"); return}
        //semi colon conveys new statement after like Obj C
        
        let datatask = session.dataTaskWithURL(potentialUrl) { (data, response, error) in   //taking URL and it's hitting return and it's starting the cycle in the browser when it's opened. We need to unwrap these optionals: data, response, error
            
            guard let data = data else { assertionFailure("Unable to get data \(error?.localizedDescription)"); return }
            //localized description means (it's a get method) retrieves the value of the error property
            //IF THERE IS NO DATA, UNWRAP THE ERROR. 
            
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String: AnyObject]] {
                
                
                //converting json object into Foundation objects w. NSJSONSerialization method.
                // creating an Array to hold these JSON dictionaries in responseArray
                //JSONObjectWithData expects an array with options
                // we don't just want any object, we want our array of dictionaries.
                // we must include an if on if let responseArray and a try? try says take your best shot at making this happen and that it may and may not work. we use an if let if this succeeds then set the value to array of dictionaries if it doesn't, forgetabout it. It's used in error handling, API calls, NSURL sessions. The array of dictionaries will not be the same in every API. That's why post man is important. 
                // if array dictionaries exists let's print them. 
                
                print(responseArray)// this is like a double optional, we need to unwrap this array of dictionaries. The very last thing it wants is to get back the array of dictionaries.
                
                
                if let responseArray = responseArray {
                    
                    
                    completion(responseArray) // we're calling the completion func closure and we're passing in our return data 
                    
                }
            }
        }
        datatask.resume()
    }
    
}

//https://api.github.com/repositories?client_id=cc6baa8a371b3e8cf9e8&client_secret=0b7359075e0d4014b9893303814bd06721e0193b







































