//
//  TableViewCell.swift
//  FindWord
//
//  Created by Serega Kushnarev on 17.12.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Init
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
