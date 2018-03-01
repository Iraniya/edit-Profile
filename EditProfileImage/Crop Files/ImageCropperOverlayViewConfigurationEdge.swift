

import UIKit

/// Edges configuration struct.
public struct ImageCropperCropViewConfigurationEdge {
    
    /// A Boolean value that determines whether the edge view is hidden.
    public var isHidden: Bool = false
    
    /// Line width for normal edge state.
    public var normalLineWidth: CGFloat = 1.0
    
    /// Line width for highlighted edge state.
    public var highlightedLineWidth: CGFloat = 3.0
    
    /// Line color for normal edge state.
    public var normalLineColor: UIColor = .white
    
    /// Line color for highlighted edge state.
    public var highlightedLineColor: UIColor = .white
}

