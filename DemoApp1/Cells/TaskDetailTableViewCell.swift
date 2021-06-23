//
//  TaskDetailTableViewCell.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 23/06/21.
//

import UIKit

class TaskDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.backgroundColor = .randomFade
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
