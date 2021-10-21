//
//  BookTableViewCell.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 13/10/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookQuantity: UILabel!
    @IBOutlet weak var bookStepper: UIStepper!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var isChecked = false
    var quantity = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        // Initialization code
        bookStepper.isEnabled = false
        self.selectionStyle = .none
    }
    
    func setUpView() {
        if !isChecked {
            checkBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
            quantity = 0
            bookStepper.isEnabled = false
            
        } else if isChecked {
            checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
            bookStepper.isEnabled = true
            
        }
    }
    
    @IBAction func checkmarkChanged(_ sender: UIButton) {
        
        if isChecked {
            checkBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
            quantity = 0
            bookStepper.isEnabled = false
            
        } else if !isChecked {
            checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            quantity = 1
            bookStepper.isEnabled = true
            
        }
        
        isChecked = !isChecked
        bookQuantity.text = "\(quantity)"
        bookStepper.value = Double(quantity)
        delegate?.addBookOrder(for: self)
        
    }
    @IBAction func changeQuantity(_ sender: UIStepper) {
        
        quantity = Int(sender.value)
        if isChecked {
            bookQuantity.text = "\(quantity)"
        }
        
        if quantity == 0 {
            isChecked = false
            checkBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
            bookStepper.isEnabled = false
        }
        delegate?.controlSomeValue(for: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
