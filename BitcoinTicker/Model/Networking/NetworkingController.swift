//
//  NetworkingController.swift
//  BitcoinTicker
//
//  Created by skander bahri on 22/12/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//


typealias SuccessCompletionHandler = (_ ask: Double?) -> ()

import Foundation
import Alamofire
import SwiftyJSON


class NetworkingServices {
    
    //static let instance = NetworkingServices()
    static weak var controller: ViewController?
    
    static func getBitCoinData(urlString: String, completion: @escaping SuccessCompletionHandler)
    {
        
        guard let url = URL(string: urlString) else
        {
            completion(nil)
            return
        }
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                    if response.result.isSuccess
                    {
                        print("Sucess! Got the BitCoin data")
                        let bitCoinJSON : JSON = JSON(response.result.value!)
                        guard let ask = bitCoinJSON["ask"].double else { completion(nil); return }
                        completion(ask)
                    } else
                    {
                        print("Error: \(String(describing: response.result.error))")
                        completion(nil)
                    }
            }
    }
    
    
  
}
