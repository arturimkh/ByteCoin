//
//  CurrencyManager.swift
//  ByteCoin
//
//  Created by Artur Imanbaev on 27.02.2023.
//

import Foundation

protocol ByteManagerDelegate{
    func didUpdateCurrency(byteCurrency: ByteModel)
}


struct CurrencyManager{
    let urlCoin = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let apiKey = "apikey=96A46822-36E8-41A8-8645-93E82CFD622C"
    var delegate: ByteManagerDelegate?
    func fetchCurrency(_ row: Int){
        let currency = currencyArray[row]
        let urlString = "\(urlCoin)/\(currency)?\(apiKey)"
        print(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let currency = self.parseJSON(byteCurrency: safeData){
                        delegate?.didUpdateCurrency(byteCurrency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(byteCurrency: Data) -> ByteModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ByteData.self, from: byteCurrency)
            let currency = decodedData.asset_id_quote
            let price = decodedData.rate
            
            let currencyModel = ByteModel(currency: currency, amountOfMoney: Int(price))
            print(currencyModel.amountOfMoney)
            return currencyModel
        }
        catch {
            print(error)
            return nil
        }
    }
    }

