
import UIKit

/// Overlay configuration struct.
public struct ImageCropperCropViewConfigurationOverlay {
    
    /// The view’s background color.
    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    /// A Boolean value that determines whether the blur effect is enable.
    ///
    /// The blur effect added over overlay view. The effect will disappear before user interaction will start. After manipulations, the effect will revert to the initial state.
    public var isBlurEnabled: Bool = true
    
    /// The intensity of the blur effect.
    public var blurStyle: UIBlurEffectStyle = .dark
    
    /// The blur effect alpha value.
    public var blurAlpha: CGFloat = 0.6
}

