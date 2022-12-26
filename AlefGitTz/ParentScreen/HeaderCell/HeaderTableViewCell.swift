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
    
    let realmManager: RealmManagerProtocol = RealmManager()
    var childs: Results<ChildModel>!
//complition handler
    var tableViewReload: () -> () = {}
    static let reuseIdentifierHeader: String = String(describing: HeaderTableViewCell.self)

    private(set) var headerView = HeaderCellView()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
      
        initializeUI()

        self.headerView.parentSurnameField.delegate = self
        self.headerView.parentNameField.delegate = self
        self.headerView.parentPatronymicField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initializeUI(){
//view loading
        contentView.addSubview(headerView)
        headerView.parentSurnameField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        headerView.parentNameField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        headerView.parentPatronymicField.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        headerView.parentAgeField.addTarget(self, action: #selector(self.filterDigitsSaveParent), for: .editingChanged)
    //function to add a child to the screen
        headerView.childButton.addTarget(self, action: #selector(addNewChild), for: .touchUpInside)
        headerView.snp.makeConstraints { make in
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
            let parents = realmManager.obtainParent()
            if parents.isEmpty == false {
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
        } else {
               return
            }
            tableViewReload()
            //print array with BD parents
                let parentArray = realmManager.obtainParent()
                print("\(parentArray)")
                print("массив родителя")
//            //print array with BD childs
//                let childArray = realmManager.obtainChild()
//                print("\(childArray)")
//                print("массив детей")
//                print("добавился ребенок")
        }
        
//the function is triggered when the data in the field changes + limiting the characters to numeric values ​​+ overwriting the parent's age in the database
  @objc private func filterDigitsSaveParent(_ textField: UITextField){
      
      //1
      if textField.text!.count > 2 {
          textField.text = String(textField.text!.prefix(2))
      }
      if  let text = textField.text, let intText = Int(text) {
          textField.text = "\(intText)"
      } else {
          textField.text = ""
      }
      //2
      let parents = realmManager.obtainParent()
      let oldParentID = parents.endIndex - 1
      let parent = ParentModel()
      let realm = try! Realm()
      try! realm.write({
          parent.parentID = parents[oldParentID].parentID
          parent.surname = headerView.parentSurnameField.text ?? ""
          parent.name = headerView.parentNameField.text ?? ""
          parent.patronymic = headerView.parentPatronymicField.text ?? ""
          parent.age = headerView.parentAgeField.text ?? ""
          realm.add(parent, update: .modified)
      })
      validParent()
      
      //print array with BD parents
      let parentsArray = realmManager.obtainParent()
      print("\(parentsArray)")
      }
    
//the function saves the parent data to the database with each change in the TextField
    @objc private func saveParentRealm(_ textField: UITextField){

        let parents = realmManager.obtainParent()
        let oldParentID = parents.endIndex - 1
        let parent = ParentModel()
        let realm = try! Realm()
        try! realm.write({
            parent.parentID = parents[oldParentID].parentID
            parent.surname = headerView.parentSurnameField.text ?? ""
            parent.name = headerView.parentNameField.text ?? ""
            parent.patronymic = headerView.parentPatronymicField.text ?? ""
            parent.age = headerView.parentAgeField.text ?? ""
            realm.add(parent, update: .modified)
        })
        //print array with BD parents
                let parentsArray = realmManager.obtainParent()
                print("\(parentsArray)")
        validParent()
    }
//validate parentForm
    func validParent(){
        if headerView.parentSurnameField.text != "",
           headerView.parentNameField.text != "",
           headerView.parentPatronymicField.text != "",
           headerView.parentAgeField.text != ""{
            headerView.childButton.isEnabled = true
            headerView.parentLabel.text = "Персональные данные"
        }else{
            headerView.childButton.isEnabled = false
            headerView.parentLabel.text = "Заполните ваши данные"
        }
    }
}
