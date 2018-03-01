//
//  ViewController.swift
//  EditProfileImage
//
//  Created by Iraniya Naynesh on 28/02/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }

    
    @IBAction func onPressedEditButton(_ sender: Any) {
        showAlertSheet()
    }
    
    @IBAction func onPressSaveButton() {
        let alertController = UIAlertController(title: "Save Profile Pic", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {(alertAction) -> Void in
            self.saveImage()
        })
        let cancle = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancle)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveImage() {
        DispatchQueue.main.async {
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, nil, nil)
        }
    }
    
    func showAlertSheet() {
        let alertController = UIAlertController(title:"Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.opernCamera()
        }
        )
        
        let galleryAcrion = UIAlertAction(title: "Open Gallery", style: UIAlertActionStyle.default, handler:
        { (alertAction) -> Void in
            self.opernGallery()
        }
        )
        
        let cancleAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(galleryAcrion)
        alertController.addAction(cancleAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Show alert message with OK button
    func showAlertMessage(alertTitle: String, alertMessage: String) {
        
        let myAlertVC = UIAlertController( title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlertVC.addAction(okAction)
        
        self.present(myAlertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedImage = newImage
            //navigateToNextViewController()
            navigateToCropViewController()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func navigateToNextViewController() {
        let cropViewControler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CropAndFilterViewController") as! CropAndFilterViewController
        
        cropViewControler.orignalImage = self.selectedImage
        cropViewControler.delegate = self
        self.navigationController?.pushViewController(cropViewControler, animated: true)
    }
    
    func navigateToCropViewController() {
        let cropViewControler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CropViewController") as! CropViewController
        
        cropViewControler.image = self.selectedImage
        cropViewControler.delegate = self
        self.navigationController?.pushViewController(cropViewControler, animated: true)
    }
   
}

//MARK:- Open Camera
extension ViewController {
    func opernCamera() {
        print("open Camera")
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            showAlertMessage(alertTitle: "Not Supported", alertMessage: "Camera not Found")
        }
    }
}


//MARK:- Gallery

extension ViewController {
    
    func opernGallery() {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Device can not access gallery.")
        }
    }
}

extension ViewController: CropAndFilterViewControllerDelegate {
    func didSelectedTheImage(withImage image: UIImage) {
        print("didSelectedTheImage Image selected")
        self.imageView.image = image
    }
}

extension ViewController: CropViewControllerDelegate {
    func didSelectedDoneButton(withImage image: UIImage) {
        self.imageView.image = image
    }
}
