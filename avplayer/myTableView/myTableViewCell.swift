//
//  myTableViewCell.swift
//  avplayer
//
//  Created by Sean Wang on 2021/3/20.
//

import UIKit

class myTableViewCell: UITableViewCell
{

    @IBOutlet var word: UILabel!
    @IBOutlet var number: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(wordT:String , numberT:Int)
    {
        word.text = wordT
        number.text = String(numberT)
    }
    
}
