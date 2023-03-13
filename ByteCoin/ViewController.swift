//
//  ViewController.swift
//  ByteCoin
//
//  Created by Artur Imanbaev on 25.02.2023.
//

import UIKit

class ViewController: UIViewController{


    let byteCoinLabel: UILabel = {
        $0.text = "ByteCoin"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 40)
        return $0
    }(UILabel())
    let moneyLabel: UILabel = {
        $0.text = "..."
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 30)
        return $0
    }(UILabel())
    let currencyPicker: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIPickerView())
    var currencyManager = CurrencyManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6151961088, green: 0.8357843161, blue: 0.9215686917, alpha: 1)
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyManager.delegate = self
        setConstraints()
        
    }
}
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyManager.fetchCurrency(row)
    }
}
extension ViewController: ByteManagerDelegate{
    func didUpdateCurrency(byteCurrency: ByteModel) {
        DispatchQueue.main.async {
            self.moneyLabel.text = "\(byteCurrency.amountOfMoney) \(byteCurrency.currency)"
        }
    }
}

extension ViewController{
    func setConstraints(){
        view.addSubview(byteCoinLabel)
        NSLayoutConstraint.activate([
            byteCoinLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            byteCoinLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: byteCoinLabel.trailingAnchor, multiplier: 5)
        ])
        view.addSubview(moneyLabel)
        NSLayoutConstraint.activate([
            moneyLabel.topAnchor.constraint(equalToSystemSpacingBelow: byteCoinLabel.bottomAnchor, multiplier: 5),
            moneyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: moneyLabel.trailingAnchor, multiplier: 5)
        ])
        view.addSubview(currencyPicker)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: currencyPicker.bottomAnchor, multiplier: 10),
            view.trailingAnchor.constraint(equalTo: currencyPicker.trailingAnchor),
            currencyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

