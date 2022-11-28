//
//  CryptoCell.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import UIKit

class CryptoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    var crypto: Crypto! {
        didSet {
            setupUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI() {
        nameLabel.text = crypto.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
