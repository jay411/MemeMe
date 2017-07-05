//
//  ViewController.swift
//  MemeMe
//
//  Created by jay raval on 7/4/17.
//  Copyright © 2017 jay raval. All rights reserved.
//

import UIKit


struct MemeModel {
    var topText: String?
    var bottomText:String?
    var originalImage: UIImage?
    var memeImage: UIImage?
    
}

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textFieldTwo: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    
    
    
    let memeTextAttributes:[String:Any] =
        [NSStrokeColorAttributeName:UIColor.black,
         NSForegroundColorAttributeName:UIColor.black,
         NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)!,
         NSStrokeWidthAttributeName:5.0] //check NSFillColor
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
        textFieldOne.defaultTextAttributes=memeTextAttributes
        textFieldTwo.defaultTextAttributes=memeTextAttributes
        textFieldOne.textAlignment=NSTextAlignment.center
        textFieldTwo.textAlignment=NSTextAlignment.center
        textFieldOne.isEnabled=false
        textFieldTwo.isEnabled=false
        textFieldOne.isHidden=true
        textFieldTwo.isHidden=true
        imagePicker.contentMode=UIViewContentMode.scaleToFill
        subscribeToKeyboardNotifications()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.text=""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("keyboard Hiding?")
        textField.resignFirstResponder()
        
        textField.backgroundColor=UIColor.clear
        
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        if let _=imagePicker.image{
            textFieldOne.isEnabled=true
            textFieldTwo.isEnabled=true
            textFieldOne.isHidden=false
            textFieldTwo.isHidden=false
        }
        print("subscribing to keyboard")
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeToKeyboardNotifications()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imagePicker: UIImageView!
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        let pickerViewController=UIImagePickerController()
        pickerViewController.delegate=self
        pickerViewController.sourceType = .photoLibrary
        self.present(pickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func pickUsingCamera(_ sender: Any) {
        let pickerViewController=UIImagePickerController()
        pickerViewController.delegate=self
        pickerViewController.sourceType = .camera
        self.present(pickerViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let activityItems=[imagePicker.image]
        
        let shareVC=UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel called")
        self.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            imagePicker.image=image
            //let isCompleted = { print("finished") }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func subscribeToKeyboardNotifications(){
        print("subscribing to keyboard inside subscribe func")
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func keyboardWillShow(_ notification:Notification){
        print("\n keyboardwillShow called")
        if (textFieldTwo.isFirstResponder && view.frame.origin.y == 0){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
        
    }
    func keyboardWillHide(_ notification:Notification){
        if (textFieldTwo.isFirstResponder){
            
            view.frame.origin.y=0
        }
        
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        print("KEYBOARD height called")
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    func generateMemedImage() -> UIImage {
        bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(self.textFieldOne.isFirstResponder){
            self.textFieldOne.resignFirstResponder()
        }
        if (self.textFieldTwo.isFirstResponder) {
            self.textFieldTwo.resignFirstResponder()
        }
        view.frame.origin.y=0
        
    }
}


