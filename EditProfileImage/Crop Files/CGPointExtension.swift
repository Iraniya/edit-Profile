import Foundation

import UIKit

/** Return centered origin value relative to other size . */


func ic_CGPointCenters(_ size1: CGSize, relativeToSize size2: CGSize) -> CGPoint {
    return CGPoint(x: size2.width / 2 - size1.width / 2, y: size2.height / 2 - size1.height / 2)
}


