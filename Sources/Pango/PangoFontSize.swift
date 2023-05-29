//
//  PangoFontSize.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

public enum PangoFontSize
{
    case points(Int32)
    case pixels(Double)

    /// A string representation appropriate for use with `pango_font_description_from_string()`
    internal var descriptionString: String
    {
        switch self
        {
        case .points(let points): return "\(points)"
        case .pixels(let pixels): return "\(pixels)px"
        }
    }
}

extension PangoFontSize: Sendable, Equatable, Hashable {}
