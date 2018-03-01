

import UIKit

/// Corners configuration struct.
public struct ImageCropperCropViewConfigurationCorner {
    
    /// A Boolean value that determines whether the corner view is hidden.
    public var isHidden: Bool = false
    
    /// Line width for normal corner state.
    public var normalLineWidth: CGFloat = 3.0
    
    /// Line width for highlighted corner state.
    public var highlightedLineWidth: CGFloat = 3.0
    
    /// Size for normal corner state.
    public var normaSize: CGSize = CGSize(width: 20, height: 20)
    
    /// Size for highlighted corner state.
    public var highlightedSize: CGSize = CGSize(width: 30, height: 30)
    
    /// Line color for normal corner state.
    public var normalLineColor: UIColor = .white
    
    /// Line color for highlighted corner state.
    public var highlightedLineColor: UIColor = .white
}

