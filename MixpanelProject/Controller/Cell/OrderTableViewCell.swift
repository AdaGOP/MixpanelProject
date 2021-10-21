//
//  OrderTableViewCell.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 13/10/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var priceBookTotal: UILabel!
    @IBOutlet weak var shippingPrice: UILabel!
    @IBOutlet weak var priceTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
