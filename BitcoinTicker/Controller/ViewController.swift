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
    
    deinit
    {
        print("Deinitialized")
    }
    

    //MARK: IBOUTLETS
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    var finalURL = ""
    var currencySelected = ""
    
    


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
        updateUI(url: finalURL)
    }
}

extension ViewController {
    

    func updateUI(url: String)
    {
        NetworkingServices.controller = self
        // Uncertain : self est optionnel
        /*NetworkingServices.getBitCoinData(urlString: url) { ask in
            DispatchQueue.main.async { [weak self] in
                guard let secureAsk = ask else { return }
                self?.bitcoinPriceLabel.text = (self?.currencySelected ?? "") + " " + "\(secureAsk)"
            }
        }*/
        
        //Certain que le controlleur est actif: self n'est pas optionnel
        /*x.getBitCoinData(urlString: url) { ask in
            DispatchQueue.main.async { [unowned self] in
                guard let secureAsk = ask else { return }
                self.bitcoinPriceLabel.text = self.currencySelected  + " " + "\(secureAsk)"
            }
        }*/
        
        
        //Certain que le controlleur est actif: self n'est pas optionnel
              NetworkingServices.getBitCoinData(urlString: url) { ask in
                  DispatchQueue.main.async { 
                      guard let secureAsk = ask else { return }
                      self.bitcoinPriceLabel.text = self.currencySelected  + " " + "\(secureAsk)"
                  }
              }
    }
}
