//
//  HeaderTableViewCell.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import SnapKit
import RealmSwift

class HeaderTableViewCell: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    let dbManager: RealmManagerProtocol = RealmManager()
    var childs: Results<ChildModel>!
//complition handler
    var tableViewReload: () -> () = {}
    static let reuseIdentifierHeader: String = String(describing: HeaderTableViewCell.self)
    
    private(set) var cellView = HeaderCellView()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        
        initializeUI()

        self.cellView.parentSurnameField.delegate = self
        self.cellView.parentNameField.delegate = self
        self.cellView.parentPatronymicField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initializeUI(){
//чтобы работали textField добавить подвид в contentMode
//view loading
        contentView.addSubview(cellView)
        cellView.parentSurnameField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.parentNameField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.parentPatronymicField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.parentAgeField.addTarget(self, action: #selector(self.saveParentRealm), for: .editingChanged)
//function to add a child to the screen
        cellView.childButton.addTarget(self, action: #selector(addNewChild), for: .touchUpInside)
        cellView.parentAgeField.addTarget(self, action: #selector(self.textFieldFilter), for: .editingChanged)
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
 
//delegate function to enter data in letters only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let letters = CharacterSet(charactersIn: "абвгдежзийклмнопрстуфхцчшщъыьэюяАБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ").inverted
       return (string.rangeOfCharacter(from: letters) == nil)
    }

//add child function
        @objc func addNewChild(){

            let parents = dbManager.obtainParent()
            let indexParent = parents.endIndex - 1
            let parent = ParentModel()
            let child = ChildModel()
            let realm = try! Realm()
            try! realm.write {
                parent.parentID = parents[indexParent].parentID
                parent.surname = parents[indexParent].surname
                parent.name = parents[indexParent].name
                parent.patronymic = parents[indexParent].patronymic
                parent.age = parents[indexParent].age
                parent.childs = parents[indexParent].childs
                parent.childs.append(child)
                realm.add(parent, update: .modified)
            }
            tableViewReload()
            
        //print array with BD parents
                let parentsArray = dbManager.obtainParent()
                print("\(parentsArray)")
                print("добавился ребенок")
        }
    
//функция срабатывает 0 при вводе данных в поле + ограничение символов ввода
    @objc private func textFieldFilter(_ textField: UITextField) {
        
        if textField.text!.lengthOfBytes(using: String.Encoding.utf8) > 2 {
            textField.text = String(textField.text!.prefix(2))
        }
        if  let text = textField.text, let intText = Int(text) {
          textField.text = "\(intText)"
        } else {
          textField.text = ""
        }
    }
    
//the function saves the parent data to the database with each change in the TextField
    @objc private func saveParentRealm(_ textField: UITextField){

        let parents = dbManager.obtainParent()
        let oldParentID = parents.endIndex - 1
        let parent = ParentModel()
        let realm = try! Realm()
        try! realm.write({
            parent.parentID = parents[oldParentID].parentID
            parent.surname = cellView.parentSurnameField.text ?? ""
            parent.name = cellView.parentNameField.text ?? ""
            parent.patronymic = cellView.parentPatronymicField.text ?? ""
            parent.age = cellView.parentAgeField.text ?? ""
            realm.add(parent, update: .modified)
        })
    }
}
