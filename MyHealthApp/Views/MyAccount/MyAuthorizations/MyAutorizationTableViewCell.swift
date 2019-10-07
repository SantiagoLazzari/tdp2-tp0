//
//  MyAutorizationTableViewCell.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 07/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class MyAutorizationTableViewCell: UITableViewCell {

    var authorization: Authorization?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var specialty: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(authorization: Authorization) {
        self.authorization = authorization
        
        self.name.text = authorization.healthProvider.name!
        self.specialty.text = authorization.specialty.name
        self.stateLabel.text = authorization.state.rawValue
        
        switch authorization.state {
        case .accepted:
            stateLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            break
        case .declined:
            stateLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            break
        case .evaluation:
            stateLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            break
        case .requested:
            stateLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            break
        }
        
    }
    
}
