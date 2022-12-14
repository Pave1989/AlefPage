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
    private(set) var childButton = UIButton(type: .system)
    
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
        parentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
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
        parentAgeField.snp.makeConstraints { make in
            make.top.equalTo(parentPatronymicField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
//Label Child
        addSubview(childLabel)
        childLabel.text = "Дети"
        childLabel.font = UIFont(name: "abosanova", size: 20)
        childLabel.snp.makeConstraints { make in
            make.top.equalTo(parentAgeField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
//LableLimit Child
        addSubview(childLimitLabel)
        childLimitLabel.text = "Можно добавить не более 5 детей"
        childLimitLabel.font = UIFont.systemFont(ofSize: 10)
        childLimitLabel.textColor = .lightGray
        childLimitLabel.numberOfLines = 1
        childLimitLabel.adjustsFontSizeToFitWidth = true
        childLimitLabel.lineBreakMode = .byClipping
        childLimitLabel.snp.makeConstraints { make in
            make.top.equalTo(childLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().inset(20)
        }
        
//Button Child
        addSubview(childButton)
        childButton.tintColor = .green
        childButton.setImage(UIImage(systemName: "plus"), for: .normal)
        childButton.setTitle("Добавить ребенка", for: .normal)
        childButton.titleLabel?.numberOfLines = 1
        childButton.titleLabel?.adjustsFontSizeToFitWidth = true
        childButton.titleLabel?.lineBreakMode = .byClipping
        childButton.layer.borderWidth = 1
        childButton.layer.cornerRadius = 20
        childButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        childButton.snp.makeConstraints { make in
            make.left.equalTo(childLimitLabel.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(parentAgeField.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
}

