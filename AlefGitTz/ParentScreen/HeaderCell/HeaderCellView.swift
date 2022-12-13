//
//  HeaderCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class HeaderCellView: UIView {
    
    private(set) var labelParent = UILabel()
    private(set) var fieldParentSurname = UITextField()
    private(set) var fieldParentName = UITextField()
    private(set) var fieldParentPatronymic = UITextField()
    private(set) var fieldParentAge = UITextField()
    private(set) var labelChild = UILabel()
    private(set) var labelLimitChild = UILabel()
    private(set) var buttonChild = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        createConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){
    
        addSubview(labelParent)
        addSubview(fieldParentName)
        addSubview(fieldParentSurname)
        addSubview(fieldParentPatronymic)
        addSubview(fieldParentAge)
        addSubview(labelChild)
        addSubview(labelLimitChild)
        addSubview(buttonChild)

//Label родителя
        labelParent.text = "Персональные данные"
//TextField родителя
        fieldParentSurname.placeholder = "Фамилия"
        fieldParentSurname.borderStyle = .roundedRect
        fieldParentSurname.adjustsFontSizeToFitWidth = true
        fieldParentName.placeholder = "Имя"
        fieldParentName.borderStyle = .roundedRect
        fieldParentPatronymic.placeholder = "Отчество"
        fieldParentPatronymic.borderStyle = .roundedRect
        fieldParentAge.placeholder = "Возраст"
        fieldParentAge.borderStyle = .roundedRect
//Label ребенка
        labelChild.text = "Дети"
        labelChild.font = UIFont(name: "abosanova", size: 20)
//LimitLable ребенка
        labelLimitChild.text = "Можно добавить не более 5 детей"
        labelLimitChild.font = UIFont.systemFont(ofSize: 10)
        labelLimitChild.textColor = .lightGray
        labelLimitChild.numberOfLines = 1
        labelLimitChild.adjustsFontSizeToFitWidth = true
        labelLimitChild.lineBreakMode = .byClipping
//Button ребенка
        buttonChild.tintColor = .green
        buttonChild.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonChild.setTitle("Добавить ребенка", for: .normal)
        buttonChild.titleLabel?.numberOfLines = 1
        buttonChild.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonChild.titleLabel?.lineBreakMode = .byClipping
        buttonChild.layer.borderWidth = 1
        buttonChild.layer.cornerRadius = 20
        buttonChild.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    private func createConstraints(){

//Label родителя
        labelParent.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
        }

//Фамилия родителя
        fieldParentSurname.snp.makeConstraints { make in
            make.top.equalTo(labelParent.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Имя родителя
        fieldParentName.snp.makeConstraints { make in
            make.top.equalTo(fieldParentSurname.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Отчество родителя
        fieldParentPatronymic.snp.makeConstraints { make in
            make.top.equalTo(fieldParentName.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Возраст родителя
        fieldParentAge.snp.makeConstraints { make in
            make.top.equalTo(fieldParentPatronymic.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Label ребенка
        labelChild.snp.makeConstraints { make in
            make.top.equalTo(fieldParentAge.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
//LimitLabel ребенка
                labelLimitChild.snp.makeConstraints { make in
                    make.top.equalTo(labelChild.snp.bottom).offset(0)
                    make.left.equalToSuperview().inset(20)
        }
//Button ребенка
        buttonChild.snp.makeConstraints { make in
            make.left.equalTo(labelLimitChild.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(fieldParentAge.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
}

