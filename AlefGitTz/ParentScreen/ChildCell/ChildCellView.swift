//
//  ChildCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class ChildCellView: UIView{
    private(set) var childNameField = UITextField()
    private(set) var childAgeField = UITextField()
    private(set) var deleteButton = UIButton(type: .system)
    private(set) var childCellSeparator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){
//Name ChldField
        addSubview(childNameField)
        childNameField.placeholder = "Имя"
        childNameField.borderStyle = .roundedRect
        childNameField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Age ChildField
        addSubview(childAgeField)
        childAgeField.placeholder = "Возраст"
        childAgeField.borderStyle = .roundedRect
        childAgeField.keyboardType = .numberPad
        childAgeField.snp.makeConstraints { make in
            make.top.equalTo(childNameField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
//Button delete
        addSubview(deleteButton)
        deleteButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        deleteButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(40)
                }
//Separator cell
        addSubview(childCellSeparator)
        childCellSeparator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        childCellSeparator.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(0)
            make.height.equalTo(1)
        }
    }
}
