//
//  RatingControl.swift
//  FoodTracking
//
//  Created by Zach Owens on 1/16/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //mark: properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet{
            updateButtonSelection()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }

    //Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not the ratingButtons array: \(ratingButtons)")
        }
        
        //calculate the button rating
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // if select represents current rating reset rating to 0
            rating = 0}
            else {
                //otherwise set rating to selected star
                rating = selectedRating
            }
        }
    
    //Private Methods
    private func setupButtons(){
        
        //clear any existing button
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "blackStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"blueStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            //create button
            let button = UIButton()
            
            //set button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add button to stack
            addArrangedSubview(button)
            
            //add new button in array
            ratingButtons.append(button)
        }
        updateButtonSelection()
    }
    
    private func updateButtonSelection() {
        for (index, button) in ratingButtons.enumerated(){
           // if index of button is less than rating, button should be selected
            button.isSelected = index < rating
            
            //set hint string for selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset rating to zero"
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
        }
            
        // Assign the hint string and value string
        button.accessibilityHint = hintString
        button.accessibilityValue = valueString
    }
}
}
