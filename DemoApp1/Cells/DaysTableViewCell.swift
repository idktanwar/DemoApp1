//
//  DaysTableViewCell.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import UIKit

class DaysTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var viewTags: UIView!
    @IBOutlet weak var btnTasks: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnTasks.layer.cornerRadius = btnTasks.frame.height/2
        btnTasks.backgroundColor = .random
        viewTags.backgroundColor = btnTasks.backgroundColor
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1), green: .random(in: 0.4...1), blue: .random(in: 0.4...1), alpha: 1)
    }
}
