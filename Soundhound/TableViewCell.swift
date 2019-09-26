//
//  TableViewCell.swift
//  Soundhound
//
//  Created by Konstantin Klyatskin on 2019-09-26.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelPlaceholder: UIView!
    
    static let kLazyLabelCellReuseId = "lazyLabelCellReuseId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        if (self.labelPlaceholder.subviews.count > 0) {
            self.labelPlaceholder.subviews[0].removeFromSuperview()
        }
    }
}
