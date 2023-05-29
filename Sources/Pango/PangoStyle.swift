//
//  PangoStyle.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoStyle
{
    case normal
    case oblique
    case italic
    case other(CPango.PangoStyle)

    init(cPangoStyle: CPango.PangoStyle)
    {
        switch cPangoStyle
        {
        case PANGO_STYLE_NORMAL:
            self = .normal

        case PANGO_STYLE_OBLIQUE:
            self = .oblique

        case PANGO_STYLE_ITALIC:
            self = .italic

        default:
            self = .other(cPangoStyle)
        }
    }

    public var cPangoStyle: CPango.PangoStyle
    {
        switch self
        {
        case .normal: return PANGO_STYLE_NORMAL
        case .oblique: return PANGO_STYLE_OBLIQUE
        case .italic: return PANGO_STYLE_ITALIC
        case .other(let style): return style
        }
    }
}

extension PangoStyle: Sendable, Equatable, Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.cPangoStyle.rawValue)
    }
}
