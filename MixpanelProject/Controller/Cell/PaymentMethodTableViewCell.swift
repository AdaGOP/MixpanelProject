//
//  PaymentMethodTableViewCell.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 13/10/21.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var choosenButton: UIButton!
    @IBOutlet weak var methodName: UILabel!
    
    var delegate: PaymentMethodTableViewCellDelegate?
    var isChoosen: Bool = false
    var methodChoosen = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }
    @IBAction func selectTheMethod(_ sender: UIButton) {
        delegate?.unCheckButton(for: self)
        if isChoosen {
            choosenButton.setImage(UIImage(systemName: "square"), for: .normal)
            methodChoosen = ""

        } else
        if !isChoosen {
            choosenButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            methodChoosen = methodName.text ?? ""
        }
        isChoosen = !isChoosen
        delegate?.toggleSomeValue(for: self)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
