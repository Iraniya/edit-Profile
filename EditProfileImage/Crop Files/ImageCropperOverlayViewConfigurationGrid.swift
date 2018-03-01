

import UIKit

/// Grid visual configuration struct.
public struct ImageCropperCropViewConfigurationGrid {
    
    /// A Boolean value that determines whether the edge view is hidden.
    public var isHidden: Bool = false
    
    /// Hide grid after user interaction.
    public var alwaysShowGrid: Bool = false
    
    /**
     The number of vertical and horizontal lines inside the crop rectangle.
     
     -  vertical: Vertical lines count.
     -  horizontal: Horizontal lines count.
     */
    public var linesCount: (vertical: Int, horizontal: Int) = (vertical: 2, horizontal: 2)
    
    /// Vertical and horizontal lines width.
    public var linesWidth: CGFloat = 1.0
    
    /// Vertical and horizontal lines color.
    public var linesColor: UIColor = UIColor.white.withAlphaComponent(0.5)
}

