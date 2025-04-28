//
//  ObserverCell.swift
//  DemoObserverPattern
//
//  Created by Alok Kumar on 29/04/25.
//

import UIKit

class ObserverCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = ""
    }
    
    func configure(observer: Observer) {
        myLabel.text = observer.message
    }
    
}
