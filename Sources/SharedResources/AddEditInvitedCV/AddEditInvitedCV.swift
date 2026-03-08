//
//  AddEditInvitedCV.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import UIKit

public class AddEditInvitedCV: UICollectionViewCell {

    @IBOutlet weak public var vw: UIView!
    @IBOutlet weak public var invitedPeopleNameLbl: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension AddEditInvitedCV {
    private func configureUI() {
        invitedPeopleNameLbl.textColor = typographyTitle
        invitedPeopleNameLbl.font = UIFont.bodySRegular()
    }
}
