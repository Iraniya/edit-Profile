

import UIKit

protocol CropViewControllerDelegate {
    func didSelectedDoneButton(withImage image: UIImage)
}

class CropViewController: UIViewController {
    
    @IBOutlet weak var cropViewStoryboard: ImageCropperView!
    var image: UIImage!
    var angle: Double = 0.0
    private var cropView: ImageCropperView {
        return cropViewStoryboard
    }
    var delegate: CropViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.isNavigationBarHidden = true
        
        cropView.image = image
        cropView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func onPressCrop(_ sender: Any) {
        cropView.showOverlayView(animationDuration: 0.3)
    }
    
    @IBAction func onPressDone(_ sender: Any) {
        guard let image = cropView.croppedImage else {
            return
        }
        self.delegate.didSelectedDoneButton(withImage: image)
        self.navigationController?.popViewController(animated: true)
    }
}

extension CropViewController: ImageCropperViewDelegate {
    
    func imageCropperViewDidChangeCropRect(view: ImageCropperView, cropRect rect: CGRect) {
        print("New crop rectangle: \(rect)")
    }
    
}
