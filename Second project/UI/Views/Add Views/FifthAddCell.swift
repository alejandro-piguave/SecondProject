//
//  FifthAddCell.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class FifthAddCell: UITableViewCell {
    
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    
    private var countries = [String]()
    
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
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                // let item = try JSONDecoder().decode(UsersDTO.self, from: responseData)
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonResult = try JSONDecoder().decode(Array<CountryDTO>.self, from: data)
                jsonResult.forEach({countries.append(getCountryInfo(from: $0))})

            } catch {
                print("ERRORRRRRRRR")
                // handle error
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
extension FifthAddCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
}
