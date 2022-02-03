//
//  QuestionTableViewCell.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 02.02.2022.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initData(questionData: Items){
        //set items
        textQuestions.text = questionData.title
        countReplayLable.text = "Count replay: \(questionData.answer_count!)"
        
        dateLable.text = "Last ack: \(questionData.last_activity_date.intToTime)"
        authtorLable.text = "Authtor: \(questionData.owner.display_name)"
        
    }

    @IBOutlet weak var textQuestions: UITextView!
    @IBOutlet weak var countReplayLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var authtorLable: UILabel!
}
