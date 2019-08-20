//
//  ViewController.swift
//  FoodTracking
//
//  Created by Zach Owens on 1/16/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by "MealTableViewController" in `prepare(for: sender)`
     or constructed as part of adding a new meal
    */
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // setup views for editing meal if already exists
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //enable save button if text field has valid meal name
        updateSaveButtonState()
        
    }

    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable save button when editing
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if user canceled
        dismiss(animated: true, completion: nil)
    }

    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //the info dictionary may contain multiple representations of an image. You want to use the original
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided with: \(info)")
        }
        
        //set photoImageView to display selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        //depending on style of presentation, the view controller will be dismissed in two ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("MealViewController is not inside a navigation controller")
        }
    }

    //this method lets you configure a view controller before its presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
       //Configure the destination view controller only when save button is pressed
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("Save button was not pressed, cancelling", log:OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //set the meal to be passed to MealViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets user pick media from photo library
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure viewController is notified when user picks photo
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    

    //MARK: Private Methods
    private func updateSaveButtonState(){
     //disable save button if no text in text field
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
    }
}
