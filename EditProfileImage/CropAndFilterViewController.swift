//
//  CropAndFilterViewController.swift
//  EditProfileImage
//
//  Created by Iraniya Naynesh on 28/02/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit
import CoreImage

protocol CropAndFilterViewControllerDelegate {
    func didSelectedTheImage(withImage image: UIImage)
}

class CropAreaView: UIView {
    override func point(inside point: CGPoint, with event:   UIEvent?) -> Bool {
        return false
    }
}

class CropAndFilterViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cropAreaView: CropAreaView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 1.5
        }
    }
    
    var orignalImage: UIImage!
    var delegate: CropAndFilterViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        ApplyFilter(withFilter: "CIGaussianBlur")
    }
    
    @IBAction func cancleButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cropImage(_ sender: Any) {
        let imgOrientation = self.imageView.image?.imageOrientation
        let imgScale = self.imageView.image?.scale
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropArea)
        let coreImage = CIImage(cgImage: croppedCGImage!)
        let ciContext = CIContext(options: nil)
        let filteredImageRef = ciContext.createCGImage(coreImage, from: coreImage.extent)
        let imageForButton = UIImage(cgImage:filteredImageRef!, scale:imgScale!, orientation:imgOrientation!)
        //imageView.image = imageForButton
        //scrollView.zoomScale = 1
        //self.cropAreaView.isHidden = true
        
        self.delegate.didSelectedTheImage(withImage: imageForButton)
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func ApplyFilter(withFilter filterName: String) {
       
        let imgOrientation = orignalImage.imageOrientation
        let imgScale = orignalImage.scale
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: orignalImage!)
        
//        let cropFilter = CIFilter(name: "CICrop")
//        cropFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        //cropFilter.setValue(Rectangle, forKey: "inputRectangle")
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        filter?.setValue(40.0, forKey: kCIInputRadiusKey)
        
        
        let output = filter!.outputImage
        let cgimg = ciContext.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!, scale: 0, orientation: imgOrientation)
        imageView.image = processedImage
        
//        let imgOrientation = orignalImage.imageOrientation
//        let imgScale = orignalImage.scale
//
//        // Create filters for each button
//
//
//        filter!.setDefaults()
//
//        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
//        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
//        let imageForButton = UIImage(cgImage:filteredImageRef!, scale:imgScale, orientation:imgOrientation)
//
//        // Assign filtered image to the button
//        imageView.image = imageForButton
    }
    
    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
//        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
//        self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, 0, 0)
//    }
    
    var cropArea:CGRect{
        get {
            let factor = imageView.image!.size.width/view.frame.width
            let scale = 1/scrollView.zoomScale
            let imageFrame = imageView.imageFrame()
            let x = (scrollView.contentOffset.x + cropAreaView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (scrollView.contentOffset.y + cropAreaView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = cropAreaView.frame.size.width * scale * factor
            let height = cropAreaView.frame.size.height * scale * factor
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
}

extension UIImageView {
    func imageFrame() -> CGRect {
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else { return CGRect.zero }
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        }else{
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }
}
