//
//  ViewController.swift
//  RContactList
//
//  Created by epita on 18/07/2019.
//  Copyright © 2019 Epita. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    var personArray : [PersonDetail]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchUsers()
    }
    
    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=10")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Person.self, from: data!)
                self.personArray = responseModel.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(responseModel)
            } catch let error {
                print("JSON Serialization ERROR: ", error)
            }
            }.resume()
    }
    
}

extension TableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        if let person = personArray?[indexPath.row] {
            print("test")
            cell.nameLabel.text = person.name.first
            cell.emailLabel.text = person.email
            
        }
        return cell
    }
    
    
}

extension TableViewController : UITableViewDelegate{
    
}


