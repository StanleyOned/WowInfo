//
//  PvPCell.swift
//  WowInfo
//
//  Created by Stanley Delacruz on 1/24/18.
//  Copyright © 2018 Stanley Delacruz. All rights reserved.
//

import UIKit

class PvPCell: UICollectionViewCell {
    
    var model: Model? {
        didSet {
            guard let rating = model?.rating, let wins = model?.seasonWins, let losses = model?.seasonLosses else {return}
            nameLabel.text = model?.name
            realmName.text = model?.realmName
            ratingLabel.text = "Rating\n\(rating)"
            winLossLabel.text = "Wins: \(wins)\nLosses: \(losses)"
            
            if model?.factionId == 0 {
                imageView.image = #imageLiteral(resourceName: "alliance")
            } else {
                imageView.image = #imageLiteral(resourceName: "horde")
            }
        }
    }
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.8)
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "alliance")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let classImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "alliance")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Rubik-Bold", size: 20)
        //l.font = UIFont.italicSystemFont(ofSize: 20)
        l.text = "Unplash"
        return l
    }()
    
    let realmName: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Rubik-Bold", size: 16)
        l.text = "Tichondrius"
        return l
    }()
    
    let ratingLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Rubik-Bold", size: 20)
        l.text = "Rating\n2900"
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let winLossLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Rubik-Bold", size: 16)
        l.text = "Win: 200\nLosses: 50"
        l.numberOfLines = 0
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(realmName)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(winLossLabel)
        
        nameLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        realmName.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        winLossLabel.anchor(top: realmName.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        imageView.anchor(top: nameLabel.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 40, height: 40)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        
        ratingLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
