//
//  ChildCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class ChildCellView: UIView{
    private(set) var fieldChildName = UITextField()
    private(set) var fielChildAge = UITextField()
    private(set) var buttonDelete = UIButton(type: .system)
    private(set) var separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        createConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){
        addSubview(fieldChildName)
        addSubview(fielChildAge)
        addSubview(buttonDelete)
        addSubview(separatorView)
        
//Имя ребенка
        fieldChildName.placeholder = "Имя"
        fieldChildName.borderStyle = .roundedRect
        
//Возраст ребенка
        fielChildAge.placeholder = "Возраст"
        fielChildAge.borderStyle = .roundedRect
//Кнопка удаления
        buttonDelete.tintColor = .red
        buttonDelete.setImage(UIImage(systemName: "minus.circle"), for: .normal)
//сепаратор
        separatorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    private func createConstraints(){

//Ребенок
        //Имя
        fieldChildName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        //Возраст
        fielChildAge.snp.makeConstraints { make in
            make.top.equalTo(fieldChildName.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        buttonDelete.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(40)
                }
//cell separator
        separatorView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(0)
            make.height.equalTo(1)
        }
   }
}
