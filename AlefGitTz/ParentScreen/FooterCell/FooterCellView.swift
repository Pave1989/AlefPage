//
//  FooterCellView.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class FooterCellView: UIView {
    private(set) var cancelButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initializeUI(){
//Button Cancel
        addSubview(cancelButton)
        cancelButton.tintColor = .red
        cancelButton.layer.cornerRadius = 20
        cancelButton.setImage(UIImage(systemName: "trash"), for: .normal)
        cancelButton.setTitle("Очистить данные", for: .normal)
        cancelButton.titleLabel?.numberOfLines = 1
        cancelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cancelButton.titleLabel?.lineBreakMode = .byClipping
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-100)
            make.left.equalToSuperview().inset(100)
        }
    }
}
