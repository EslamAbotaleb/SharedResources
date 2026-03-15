//
//  ProfilePhoneTypesCell.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//

import UIKit

public class ProfilePhoneTypesCell: UITableViewCell {
    
    // MARK: - Properties
    public static let nibName = "ProfilePhoneTypesCell"
    public static let reuseIdentifier = "ProfilePhoneTypesCell"
    
    // Returns the UINib for this cell with the correct bundle
    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle.module)
    }

    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var checkSortNameLbl: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
   
    public func configure(item: ListModel) {
        checkSortNameLbl.text = item.name
        checkSortNameLbl.font = UIFont.bodyLRegular()
        
        if item.isSelected ?? false {
            checkIcon.isHidden = false
            checkSortNameLbl.textColor = typographyBody
        }else {
            checkIcon.isHidden = true
            checkSortNameLbl.textColor = typographyTitle
        }
        
    }
    
}
