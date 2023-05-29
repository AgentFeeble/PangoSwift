//
//  CGRect+Extensions.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango
import Foundation

extension CGRect
{
    public init(pangoRectangle: PangoRectangle)
    {
        self.init(
            origin: CGPoint(
                x: CGFloat(pangoRectangle.x),
                y: CGFloat(pangoRectangle.y)
            ),
            size: CGSize(
                width: CGFloat(pangoRectangle.width),
                height: CGFloat(pangoRectangle.height)
            )
        )
    }
}

extension PangoRectangle
{
    public var cgRect: CGRect
    {
        return CGRect(pangoRectangle: self)
    }
}
