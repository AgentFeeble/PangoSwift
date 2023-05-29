//
//  PangoFontMask.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public struct PangoFontMask: OptionSet
{
    public var rawValue: UInt32

    public init(rawValue: UInt32)
    {
        self.rawValue = rawValue
    }

    public init(_ fontMask: CPango.PangoFontMask)
    {
        self.rawValue = fontMask.rawValue
    }

    public var cPangoFontMask: CPango.PangoFontMask
    {
        return CPango.PangoFontMask(self.rawValue)
    }

    public static var family = PangoFontMask(PANGO_FONT_MASK_FAMILY)
    public static var style = PangoFontMask(PANGO_FONT_MASK_STYLE)
    public static var variant = PangoFontMask(PANGO_FONT_MASK_VARIANT)
    public static var weight = PangoFontMask(PANGO_FONT_MASK_WEIGHT)
    public static var stretch = PangoFontMask(PANGO_FONT_MASK_STRETCH)
    public static var size = PangoFontMask(PANGO_FONT_MASK_SIZE)
    public static var gravity = PangoFontMask(PANGO_FONT_MASK_GRAVITY)
    public static var variations = PangoFontMask(PANGO_FONT_MASK_VARIATIONS)
}

extension PangoFontMask: Sendable, Equatable, Hashable {}
