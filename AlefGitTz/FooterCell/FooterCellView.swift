//
//  FooterCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class FooterCellView: UIView {
    private(set) var buttonCancel = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        createConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){

        addSubview(buttonCancel)
//Button отмены
        buttonCancel.tintColor = .red
        buttonCancel.layer.cornerRadius = 20
        buttonCancel.setImage(UIImage(systemName: "trash"), for: .normal)
        buttonCancel.setTitle("Очистить данные", for: .normal)
        buttonCancel.titleLabel?.numberOfLines = 1
        buttonCancel.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonCancel.titleLabel?.lineBreakMode = .byClipping
        buttonCancel.layer.borderWidth = 1
        buttonCancel.layer.cornerRadius = 20
        buttonCancel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    private func createConstraints(){


//Button отмены
        buttonCancel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-100)
            make.left.equalToSuperview().inset(100)
        }
    }
}
