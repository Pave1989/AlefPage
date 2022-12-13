//
//  ChildTableViewCell.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import RealmSwift
 
class ChildTableViewCell: UITableViewCell, UITextFieldDelegate {
    let dbManager: RealmManagerProtocol = RealmManager()
    //complition handler
    var didDelete: () -> () = {}
    
    private(set) var cellView = ChildCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeUI()
        createConstraints()
        self.cellView.fieldChildName.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI(){
        //чтобы работали textField добавить подвид в contentMode
        contentView.addSubview(cellView)
        cellView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellView.buttonDelete.addTarget(self, action: #selector(deleteChild), for: .touchUpInside)
        cellView.fieldChildName.addTarget(self, action: #selector(saveChildRealm), for: .editingChanged)
        cellView.fielChildAge.addTarget(self, action: #selector(nameFilterDigits), for: .editingChanged)
        cellView.fielChildAge.addTarget(self, action: #selector(saveChildRealm), for: .editingChanged)
    }
    
    private func createConstraints(){
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
//функция срабатывает 0 при вводе данных в поле + ограничение символов ввода
    @objc func nameFilterDigits(_ textField: UITextField){
        if textField.text!.lengthOfBytes(using: String.Encoding.utf8) > 2 {
            textField.text = String(textField.text!.prefix(2))
        }
        if  let text = textField.text, let intText = Int(text) {
          textField.text = "\(intText)"
        } else {
          textField.text = ""
        }
    }
    //функция сохраняет родительские данные в бд с каждым изменением поля TextField
    @objc func saveChildRealm(_ textField: UITextField){

        let childs = dbManager.obtainChild()
        let oldChildId = childs.endIndex - 1
        let child = ChildModel()
        let realm = try! Realm()
        try! realm.write({
            child.childID = childs[oldChildId].childID
            child.name = cellView.fieldChildName.text ?? ""
            child.age = cellView.fielChildAge.text ?? ""
            if  child.name != "" &&
                child.age != ""{
                realm.add(child, update: .modified)
            } else {
                return
            }
            
        })
        //принт массива с детьми
            let childArray = dbManager.obtainChild()
            print("\(childArray)")
        //принт массива с родителями бд
        let parents = dbManager.obtainParent()
        print("\(parents)")
    }

    //функция с замыканием удаления ребенка
    @objc func deleteChild(){
        didDelete()
    }
    //функия делегата для ввода данных только буквами
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let letters = CharacterSet(charactersIn: "абвгдежзийклмнопрстуфхцчшщъыьэюяАБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ").inverted
       return (string.rangeOfCharacter(from: letters) == nil)
    }
}
