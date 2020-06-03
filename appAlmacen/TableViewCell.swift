//
//  TableViewCell.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblProducto: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblExistencia: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
