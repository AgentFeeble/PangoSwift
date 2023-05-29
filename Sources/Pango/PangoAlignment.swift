//
//  PangoAlignment.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoAlignment
{
    case left
    case center
    case right
    case other(CPango.PangoAlignment)

    init(cPangoAlignment: CPango.PangoAlignment)
    {
        switch cPangoAlignment
        {
        case PANGO_ALIGN_LEFT:
            self = .left

        case PANGO_ALIGN_CENTER:
            self = .center

        case PANGO_ALIGN_RIGHT:
            self = .right

        default:
            self = .other(cPangoAlignment)
        }
    }

    public var cPangoAlignment: CPango.PangoAlignment
    {
        switch self
        {
        case .left: return PANGO_ALIGN_LEFT
        case .center: return PANGO_ALIGN_CENTER
        case .right: return PANGO_ALIGN_RIGHT
        case .other(let alignment): return alignment
        }
    }
}
