//
//  ViewController.swift
//  CharactersApp
//
//  Created by Amairany Servin Salazar on 4/23/19.
//  Copyright © 2019 Amairany Servin Salazar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refCharacter: DatabaseReference!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSkill: UITextField!
    @IBOutlet weak var txtWeakness: UITextField!
    @IBOutlet weak var txtUniverse: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var tblCharacters: UITableView!

    var charactersList = [CharactersModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let character = charactersList[indexPath.row]
        
        let alertController = UIAlertController(title:character.name, message:"Give new values to update character", preferredStyle: .alert)
        let updateAction = UIAlertAction(title:"Update", style:.default, handler:{ (action) in
            let id = character.id
            let name = alertController.textFields?[0].text
            let skill = alertController.textFields?[1].text
            let weakness = alertController.textFields?[2].text
            let universe = alertController.textFields?[3].text
            
            self.updateCharacter(id: id!, name: name!, skill: skill!, weakness: weakness!, universe: universe!)
            
        })
        let deleteAction = UIAlertAction(title:"Delete", style:.default, handler:{ (action) in
            self.deleteCharacter(id: character.id!)
            
        })
        alertController.addTextField{(textField) in
            textField.text = character.name
        }
        alertController.addTextField{(textField) in
            textField.text = character.skill
        }
        alertController.addTextField{(textField) in
            textField.text = character.weakness
        }
        alertController.addTextField{(textField) in
            textField.text = character.universe
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present(alertController, animated:true, completion: nil)
    }
    
    func updateCharacter(id: String, name: String, skill: String, weakness: String, universe: String){
        let character = [
            "id": id,
            "characterName": name,
            "characterSkill": skill,
            "characterWeakness": weakness,
            "characterUniverse": universe
        ]
        refCharacter.child(id).setValue(character)
        lblMessage.text = "Character Updated"
    }
    
    func deleteCharacter(id: String){
        refCharacter.child(id).setValue(nil)
        lblMessage.text = "Character Removed"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let character: CharactersModel
        
        character = charactersList[indexPath.row]
        cell.lblName.text = character.name
        cell.lblSkill.text = character.skill
        cell.lblWeakness.text = character.weakness
        cell.lblUniverse.text = character.universe
        
        return cell
    }
    
    @IBAction func btnAddCharacter(_ sender: UIButton) {
        addCharacter()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  //      FirebaseApp.configure()
        refCharacter = Database.database().reference().child("characters");
        refCharacter.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.charactersList.removeAll()
                for characters in snapshot.children.allObjects as![DataSnapshot]{
                    let characterObject = characters.value as? [String: AnyObject]
                    let characterName = characterObject?["characterName"]
                    let characterSkill = characterObject?["characterSkill"]
                    let characterWeakness = characterObject?["characterWeakness"]
                    let characterUniverse = characterObject?["characterUniverse"]
                    let characterId = characterObject?["id"]
                    let character = CharactersModel(id: characterId as! String?, name: characterName as! String?, skill: characterSkill as! String?, weakness: characterWeakness as! String?, universe: characterUniverse as! String?)
                    self.charactersList.append(character)
                }
                self.tblCharacters.reloadData()
            }
        })
        
    }
    
    func addCharacter(){
        let key = refCharacter.childByAutoId().key
        let character = ["id":key,
                         "characterName": txtName.text! as String,
                         "characterSkill": txtSkill.text! as String,
                         "characterWeakness": txtWeakness.text! as String,
                         "characterUniverse": txtUniverse.text! as String]
        
        refCharacter.child(key!).setValue(character)
        lblMessage.text = "Character Added"
        txtName.text = ""
        txtSkill.text = ""
        txtWeakness.text = ""
        txtUniverse.text = ""
    }


}

