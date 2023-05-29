//
//  PangoStretch.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoStretch
{
    case ultraCondensed
    case extraCondensed
    case condensed
    case semiCondensed
    case normal
    case semiExpanded
    case expanded
    case extraExpanded
    case ultraExpanded
    case other(CPango.PangoStretch)

    init(cPangoStretch: CPango.PangoStretch)
    {
        switch cPangoStretch
        {
        case PANGO_STRETCH_ULTRA_CONDENSED:
            self = .ultraCondensed

        case PANGO_STRETCH_EXTRA_CONDENSED:
            self = .extraCondensed

        case PANGO_STRETCH_CONDENSED:
            self = .condensed

        case PANGO_STRETCH_SEMI_CONDENSED:
            self = .semiCondensed

        case PANGO_STRETCH_NORMAL:
            self = .normal

        case PANGO_STRETCH_SEMI_EXPANDED:
            self = .semiExpanded

        case PANGO_STRETCH_EXPANDED:
            self = .expanded

        case PANGO_STRETCH_EXTRA_EXPANDED:
            self = .extraExpanded

        case PANGO_STRETCH_ULTRA_EXPANDED:
            self = .ultraExpanded

        default:
            self = .other(cPangoStretch)
        }
    }

    public var cPangoStretch: CPango.PangoStretch
    {
        switch self
        {
        case .ultraCondensed: return PANGO_STRETCH_ULTRA_CONDENSED
        case .extraCondensed: return PANGO_STRETCH_EXTRA_CONDENSED
        case .condensed: return PANGO_STRETCH_CONDENSED
        case .semiCondensed: return PANGO_STRETCH_SEMI_CONDENSED
        case .normal: return PANGO_STRETCH_NORMAL
        case .semiExpanded: return PANGO_STRETCH_SEMI_EXPANDED
        case .expanded: return PANGO_STRETCH_EXPANDED
        case .extraExpanded: return PANGO_STRETCH_EXTRA_EXPANDED
        case .ultraExpanded: return PANGO_STRETCH_ULTRA_EXPANDED
        case .other(let pangoStretch): return pangoStretch
        }
    }
}

extension PangoStretch: Sendable, Equatable, Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.cPangoStretch.rawValue)
    }
}
