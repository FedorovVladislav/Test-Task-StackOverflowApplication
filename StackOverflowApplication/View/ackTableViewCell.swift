//
//  ackTableViewCell.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 03.02.2022.
//

import UIKit

class ackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var imageUIImage: UIImageView!
    @IBOutlet weak var authtorLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var replayLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initData(answerdata: Items) {
       // textTextView.text = answerdata.body
        authtorLable.text = "Author: \(answerdata.owner.display_name)"
        dateLable.text = "Data: \(answerdata.last_activity_date.intToTime)"
        replayLable.text = "Like: \(answerdata.score!)"
        
        
        if let is_accepted = answerdata.is_accepted {
            
            imageUIImage.image = UIImage(systemName: "checkmark")
            if is_accepted{
            print("is_accepted")
            imageUIImage.tintColor = .green
        } else {
            imageUIImage.tintColor = .gray
        }
        
        } else {
            self.backgroundColor = .gray
        }
        
    }
}
