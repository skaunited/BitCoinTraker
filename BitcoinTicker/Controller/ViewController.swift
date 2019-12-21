//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by skander bahri on 21/12/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController
{
    var finalURL = ""
    var currencySelected = ""
    //MARK: IBOUTLETS
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    //MARK: LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
}
// MARK: EXTENSION
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return CURRENCY_ARRAY.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return CURRENCY_ARRAY[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        currencySelected = CURRENCCY_SYMBOLE_ARRAY[row]
        finalURL = BASE_URL + CURRENCY_ARRAY[row]
        getBitCoinData(url: finalURL)
    }
}

extension ViewController {
    
    func getBitCoinData(url: String)
    {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                                if response.result.isSuccess {
                                    print("Sucess! Got the BitCoin data")
                                    let bitCoinJSON : JSON = JSON(response.result.value!)
                                    self.updateBitcoinData(json : bitCoinJSON)
                                } else {
                                    print("Error: \(String(describing: response.result.error))")
                                    self.bitcoinPriceLabel.text = CONNECTION_ISSUE
                                }
            }
    }
    
    func updateBitcoinData(json : JSON){
        if let bitCoinResult = json["ask"].double{
            self.bitcoinPriceLabel.text = self.currencySelected + " " + String(bitCoinResult)
        }else{
            self.bitcoinPriceLabel.text = PRIX_NON_DISPONIBLE
        }
    }
}
