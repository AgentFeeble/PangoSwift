//
//  PangoEllipsizeMode.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoEllipsizeMode
{
    case none
    case start
    case middle
    case end
    case other(CPango.PangoEllipsizeMode)

    init(cPangoEllipsizeMode: CPango.PangoEllipsizeMode)
    {
        switch cPangoEllipsizeMode
        {
        case PANGO_ELLIPSIZE_NONE:
            self = .none

        case PANGO_ELLIPSIZE_START:
            self = .start

        case PANGO_ELLIPSIZE_MIDDLE:
            self = .middle

        case PANGO_ELLIPSIZE_END:
            self = .end

        default:
            self = .other(cPangoEllipsizeMode)
        }
    }

    public var cPangoEllipsizeMode: CPango.PangoEllipsizeMode
    {
        switch self
        {
        case .none: return PANGO_ELLIPSIZE_NONE
        case .start: return PANGO_ELLIPSIZE_START
        case .middle: return PANGO_ELLIPSIZE_MIDDLE
        case .end: return PANGO_ELLIPSIZE_END
        case .other(let wrap): return wrap
        }
    }
}

