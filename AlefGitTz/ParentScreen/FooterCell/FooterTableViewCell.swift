//
//  FooterTableViewCell.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit

class FooterTableViewCell: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    static let reuseIdentifierFooter: String = String(describing: FooterTableViewCell.self)
    
    private(set) var cellView = FooterCellView()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        initializeUI()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func initializeUI(){
        //чтобы работали textField добавить подвид в contentMode
        contentView.addSubview(cellView)
    }
    private func createConstraints(){
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}
