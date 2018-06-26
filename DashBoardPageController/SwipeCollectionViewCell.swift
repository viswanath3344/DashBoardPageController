//
//  SwipeCollectionViewCell.swift
//  DashBoardPageController
//
//  Created by Ming-En Liu on 26/06/18.
//  Copyright © 2018 Vedas labs. All rights reserved.
//

import UIKit

class SwipeCollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        // Setup Page Variable
        didSet {

            // verifying Page variable has value or not.
             guard let unwrapPage = page else {
                return
             }
            
            imageView.image = UIImage(named: unwrapPage.imageName)
            
            let attributedString  = NSMutableAttributedString.init(string: unwrapPage.title, attributes: [NSAttributedStringKey.foregroundColor:UIColor.red,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16)])
            attributedString.append(NSMutableAttributedString(string: "\n\n\n \(unwrapPage.subTitle)", attributes: [NSAttributedStringKey.foregroundColor:UIColor.gray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]))
            textView.attributedText = attributedString
            textView.textAlignment = .center
            
        }
    }
    
   private let imageView:UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "SuperMario1"))
    
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
   private let textView:UITextView = {
        
        let textView = UITextView()
        textView.textColor = UIColor.purple
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        var attributedString  = NSMutableAttributedString.init(string: "Super Mario Game", attributes: [NSAttributedStringKey.foregroundColor:UIColor.red,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: "\n\n\n Super Mario Bros. is a platform video game developed and published by Nintendo. The successor to the 1983 arcade game, Mario Bros., it was released in Japan in 1985 for the Famicom, and in North America", attributes: [NSAttributedStringKey.foregroundColor:UIColor.gray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]))
        textView.attributedText = attributedString
        textView.textAlignment = .center
        return textView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints()  {
        
        // Giving Constraints to Imageview
        
        let imageContainerView  = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageContainerView)

        imageContainerView.addSubview(imageView)
        self.addSubview(imageContainerView)
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo:trailingAnchor),
            imageContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
            ])
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageContainerView.widthAnchor, multiplier: 0.5)
            ])
        
        self.addSubview(textView)
        // Giving Constraints to TextView
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
        
        
    }
   
}
