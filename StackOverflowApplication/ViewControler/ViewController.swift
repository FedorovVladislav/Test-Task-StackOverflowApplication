//
//  ViewController.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 28.01.2022.
//

import UIKit
import CoreData

enum DataTag: String, CaseIterable {
    
    case objC       = "Objective-C"
    case ios        = "IOS"
    case iphone     = "IPhone"
    case xCode      = "XCode"
    case cocoaTouch = "Cocoa Touch"
}

class ViewController: UIViewController {

    
    
    // MARK: - Variable
    var cellectTag =  1
    let networkManager = NetworkManager()
    var questionsList: QuestionsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.dataSource = self
        questionTableView.delegate = self
        
        self.title = DataTag.allCases[self.cellectTag].rawValue
        getData()
        
    }
    
    // MARK: - Storyboard element
    @IBOutlet weak var questionTableView: UITableView!
    
    @IBOutlet weak var tagButton: UIBarButtonItem!
    
    @IBAction func setTagButtonItem(_ sender: UIBarButtonItem) {
        
        self.present(pickerViewControler(), animated: true, completion: nil )
    }

    private func updateTableView(index:Int ){
        // заголовок навигешион контроллера
        self.title = DataTag.allCases[self.cellectTag].rawValue
        // делаем запрос данныхс сервера
        getData()
    }
    
    func getData(){
        self.questionTableView.reloadData()
        
        networkManager.fetchQuestionList(tag: DataTag.allCases[self.cellectTag], completion: { data, error in
            guard let data = data else {
                print ("wrong data: \(error)")
                return
            }
            self.questionsList = data
            self.questionTableView.reloadData()
        })
    }
    
    private func pickerViewControler () -> UIAlertController {
        
        let widthSize = view.frame.width - 10
        let heightSize = view.frame.height / 4
        // создаем вью и устанавливаем разамеры
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: widthSize, height: heightSize )
        // создаем пикер с размерами вью
        let pickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: widthSize, height: heightSize))
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(cellectTag, inComponent: 0, animated: true)
        // добавляем пикер на вью
        vc.view.addSubview(pickerView)
        
        //ставим контрейнт по центру
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        
        // создаем вспылвающее окно
        let alert = UIAlertController(title: "Set Tag", message: nil, preferredStyle: .actionSheet)
    
        // устанавливаем вс на алерт контроллер
        alert.setValue(vc, forKey: "contentViewController")
        // кнопки
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
            self.cellectTag = pickerView.selectedRow(inComponent: 0)
           
            // обновляем таблицу
            self.updateTableView(index: self.cellectTag)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) in
        }))
        return alert
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataTag.allCases[row].rawValue
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let questionsList = questionsList else { return 0 }
        
        return questionsList.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionTableViewCell{
            guard let questionData = questionsList?.items[indexPath.row]  else { return cell }
            cell.initData(questionData: questionData)
            
            cell.accessoryType = .detailButton
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let ackVC = mainStoryBoard.instantiateViewController(withIdentifier: "ackVC") as? AckViewController  {
            
            guard let questionId = questionsList?.items[indexPath.row].question_id else { return }
            ackVC.questionId = questionId
            ackVC.question = questionsList?.items[indexPath.row]
            
            show(ackVC, sender: nil)
       
        }
    }
    
}

