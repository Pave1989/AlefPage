//
//  ParentTableViewController.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import RealmSwift

class ParentTableViewController: UITableViewController {

    let dbManager: RealmManagerProtocol = RealmManager()
    var childs: Results<ChildModel>!
    let cellID = "reuseIdentifier"
    let headerID = "reuseIdentierHeader"
    //complition handler
    var cleanParent: () -> () = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //принт массива с родителями бд
            let parentsArray = dbManager.obtainParent()
            print("\(parentsArray)")
            print("массив родителя")
//        //принт массива с детьми
//            let childArray = dbManager.obtainChild()
//            print("\(childArray)")
//            print("массив детей")
        
        let realm = try! Realm()
        self.childs = realm.objects(ChildModel.self)
        self.tableView?.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableViewCell.reuseIdentifierHeader)
        tableView.register(FooterTableViewCell.self, forHeaderFooterViewReuseIdentifier: FooterTableViewCell.reuseIdentifierFooter)
        self.tableView?.register(ChildTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.separatorStyle = .none
    }

    //колличество детей в массиве
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return childs.count
        }

    //Child cell
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChildTableViewCell
           //присвоение текстфилдам значений
            let childs = dbManager.obtainChild()
            cell.cellView.fieldChildName.text = childs[indexPath.row].name
            cell.cellView.fielChildAge.text = "\(childs[indexPath.row].age)"

    //удаление по индексу ячейки
                cell.didDelete = { [weak self] in
                    guard let self = self else {return}
                    let child = self.childs[indexPath.row]
                    self.dbManager.removeObject(object: child)
    //    self.tableView.deleteRows(at: [indexPath], with: .right)
                    self.tableView.reloadData()
                }
            return cell
        }
    //высота ячейки child
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 95
        }
    //Header
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableViewCell.reuseIdentifierHeader) as! HeaderTableViewCell

            let parentsArray = dbManager.obtainParent()
            //создание модели родителя если массив пустой
            if parentsArray.isEmpty == true{
                header.cellView.fieldParentSurname.text = ""
                header.cellView.fieldParentName.text = ""
                header.cellView.fieldParentPatronymic.text = ""
                header.cellView.fieldParentAge.text = ""
                tableView.reloadData()
                
                let parent = ParentModel()
                dbManager.saveParent(parent: parent)
            }else{
            let indexParent = parentsArray.endIndex - 1
            header.cellView.fieldParentSurname.text = parentsArray[indexParent].surname
            header.cellView.fieldParentName.text = parentsArray[indexParent].name
            header.cellView.fieldParentPatronymic.text = parentsArray[indexParent].patronymic
            header.cellView.fieldParentAge.text = parentsArray[indexParent].age
            }
            //перезапуск tableView
            header.tableViewReload = { [weak self] in
                guard let self = self else {return}
                self.tableView.reloadData()
            }
            //скрытие кнопки
            if childs.count == 5{
                header.cellView.buttonChild.isHidden = true
            }else{
                header.cellView.buttonChild.isHidden = false
            }
            return header
        }
    //высота ячейки header
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 310
        }
    //FOOTER
        override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
             let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterTableViewCell.reuseIdentifierFooter) as! FooterTableViewCell
            footer.cellView.buttonCancel.addTarget(self, action: #selector(deleteInfo), for: .touchUpInside)
           
            return footer
        }
    //высота ячейки footer
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 70
        }
    //функция алерта
        @objc func deleteInfo(){
            let alert = UIAlertController(title: "Очистить профиль?", message: "", preferredStyle: .alert)
            let deleteParent = UIAlertAction(title: "Удалить данные", style: .destructive){(alert) in
                self.dbManager.clearAll()
                self.tableView.reloadData()
                print("Данные удалены")
            }
            alert.addAction(deleteParent)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: .none))
            self.present(alert, animated: true, completion: nil)
        }
}

