//
//  HeaderCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class HeaderCellView: UIView {
    
    private(set) var parentLabel = UILabel()
    private(set) var parentSurnameField = UITextField()
    private(set) var parentNameField = UITextField()
    private(set) var parentPatronymicField = UITextField()
    private(set) var parentAgeField = UITextField()
    private(set) var childLabel = UILabel()
    private(set) var childLimitLabel = UILabel()
    private(set) var childButton = AddChildButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){
//Label Parent
        addSubview(parentLabel)
        parentLabel.text = "Персональные данные"
        parentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        parentLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        parentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
        }
        
//Surname ParentField
        addSubview(parentSurnameField)
        parentSurnameField.placeholder = "Фамилия"
        parentSurnameField.borderStyle = .roundedRect
        parentSurnameField.adjustsFontSizeToFitWidth = true
        parentSurnameField.snp.makeConstraints { make in
            make.top.equalTo(parentLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
//Name ParentField
        addSubview(parentNameField)
        parentNameField.placeholder = "Имя"
        parentNameField.borderStyle = .roundedRect
        parentNameField.snp.makeConstraints { make in
            make.top.equalTo(parentSurnameField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
//Patronymic ParentField
        addSubview(parentPatronymicField)
        parentPatronymicField.placeholder = "Отчество"
        parentPatronymicField.borderStyle = .roundedRect
        parentPatronymicField.snp.makeConstraints { make in
            make.top.equalTo(parentNameField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
//Age ParentField
        addSubview(parentAgeField)
        parentAgeField.placeholder = "Возраст"
        parentAgeField.borderStyle = .roundedRect
        parentAgeField.keyboardType = .numberPad
        parentAgeField.snp.makeConstraints { make in
            make.top.equalTo(parentPatronymicField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
//Label Child
        addSubview(childLabel)
        childLabel.text = "Дети"
        childLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        childLabel.font = UIFont.systemFont(ofSize: 20)
        childLabel.numberOfLines = 1
        childLabel.adjustsFontSizeToFitWidth = true
        childLabel.lineBreakMode = .byClipping
        childLabel.snp.makeConstraints { make in
            make.top.equalTo(parentAgeField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
//LableLimit Child
        addSubview(childLimitLabel)
        childLimitLabel.text = "Можно добавить не более 5 детей"
        childLimitLabel.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        childLimitLabel.font = UIFont.systemFont(ofSize: 10)
        childLimitLabel.numberOfLines = 1
        childLimitLabel.adjustsFontSizeToFitWidth = true
        childLimitLabel.lineBreakMode = .byClipping
        childLimitLabel.snp.makeConstraints { make in
            make.top.equalTo(childLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().inset(20)
        }
        
//Button Child
        addSubview(childButton)
        childButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        childButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        childButton.setImage(UIImage(systemName: "plus"), for: .normal)
        childButton.setTitle("Добавить ребенка", for: .normal)
        childButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        childButton.titleLabel?.numberOfLines = 1
        childButton.titleLabel?.adjustsFontSizeToFitWidth = true
        childButton.titleLabel?.lineBreakMode = .byClipping
        childButton.layer.cornerRadius = 20
        childButton.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        childButton.isEnabled = false
        childButton.snp.makeConstraints { make in
            make.left.equalTo(childLimitLabel.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(parentAgeField.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
}

