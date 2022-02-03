//
//  AckViewController.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 03.02.2022.
//

import UIKit

class AckViewController: UIViewController {
    
    @IBOutlet weak var ansTableView: UITableView!
    
    let networkManager = NetworkManager()
    var ansList: AnswerData?
    var question: Items?
    var questionId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        ansTableView.dataSource = self
        
        getData()
    }
    
    func getData(){

        networkManager.fetchAnsList(question: questionId, completion: { data, error in
            guard let data = data else {
                print ("wrong data: \(error)")
                return
            }
            self.ansList = data
            self.ansTableView.reloadData()
        })
    }
}
extension AckViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = ansList?.items.count {
            return count + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Asckell", for: indexPath) as? ackTableViewCell {
            
            if indexPath.row > 0 {
                guard let item = ansList?.items[indexPath.row - 1] else { return cell }
                cell.initData(answerdata: item)
                return cell
            } else {
                guard let item = question else { return cell }
                cell.initData(answerdata: item)
                return cell
            }
        }
        return UITableViewCell()
      
    }
}
