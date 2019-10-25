//
//  FifthAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class FifthAddCell: UITableViewCell {
    static var typeName: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var streetNameTF: UITextField!
    @IBOutlet weak var streetNumberTF: UITextField!
    
    var countries = Array<CountryDTO>()
    
    var selectedCountry: CountryDTO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personView.layer.cornerRadius = 10
        
        // shadow
        personView.layer.shadowColor = UIColor.black.cgColor
        personView.layer.shadowOffset = CGSize(width: 3, height: 3)
        personView.layer.shadowOpacity = 0.7
        personView.layer.shadowRadius = 4.0
        // Initialization code
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        streetNumberTF.delegate = self
        streetNumberTF.keyboardType = .numberPad
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                countries = try JSONDecoder().decode(Array<CountryDTO>.self, from: data)
            } catch {
                print("ERRORRRRRRRR")
                // handle error
            }
        }
    }

    private func getCountryInfo(from countryDTO: CountryDTO) -> String {
        return "\(countryDTO.name ?? "") \(flag(from: countryDTO.code))"
    }
    private func flag(from ccode: String?) -> String {
        guard let nat = ccode else {
            return ""
        }
        let base : UInt32 = 127397
        var s = ""
        for v in nat.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
extension FifthAddCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}
extension FifthAddCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getCountryInfo(from: countries[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
    }
}
