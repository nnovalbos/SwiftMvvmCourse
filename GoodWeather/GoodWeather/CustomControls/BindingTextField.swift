//
//  BindingTextField.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 04/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeClosure : (String) -> () = {_ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         commonInit()
    }
    
    func bind(callback : @escaping (String) -> ()){
        self.textChangeClosure  = callback
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        if let text = textField.text {
            textChangeClosure(text)
        }
        
    }
}
