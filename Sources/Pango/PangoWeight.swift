//
//  PangoWeight.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoWeight
{
    case thin
    case ultralight
    case light
    case semilight
    case book
    case normal
    case medium
    case semibold
    case bold
    case ultrabold
    case heavy
    case ultraheavy
    case other(CPango.PangoWeight)

    init(cPangoWeight: CPango.PangoWeight)
    {
        switch cPangoWeight
        {
        case PANGO_WEIGHT_THIN:
            self = .thin

        case PANGO_WEIGHT_ULTRALIGHT:
            self = .ultralight

        case PANGO_WEIGHT_LIGHT:
            self = .light

        case PANGO_WEIGHT_SEMILIGHT:
            self = .semilight

        case PANGO_WEIGHT_BOOK:
            self = .book

        case PANGO_WEIGHT_NORMAL:
            self = .normal

        case PANGO_WEIGHT_MEDIUM:
            self = .medium

        case PANGO_WEIGHT_SEMIBOLD:
            self = .semibold

        case PANGO_WEIGHT_BOLD:
            self = .bold

        case PANGO_WEIGHT_ULTRABOLD:
            self = .ultrabold

        case PANGO_WEIGHT_HEAVY:
            self = .heavy

        case PANGO_WEIGHT_ULTRAHEAVY:
            self = .ultraheavy

        default:
            self = .other(cPangoWeight)
        }
    }

    public var cPangoWeight: CPango.PangoWeight
    {
        switch self
        {
        case .thin: return PANGO_WEIGHT_THIN
        case .ultralight: return PANGO_WEIGHT_ULTRALIGHT
        case .light: return PANGO_WEIGHT_LIGHT
        case .semilight: return PANGO_WEIGHT_SEMILIGHT
        case .book: return PANGO_WEIGHT_BOOK
        case .normal: return PANGO_WEIGHT_NORMAL
        case .medium: return PANGO_WEIGHT_MEDIUM
        case .semibold: return PANGO_WEIGHT_SEMIBOLD
        case .bold: return PANGO_WEIGHT_BOLD
        case .ultrabold: return PANGO_WEIGHT_ULTRABOLD
        case .heavy: return PANGO_WEIGHT_HEAVY
        case .ultraheavy: return PANGO_WEIGHT_ULTRAHEAVY
        case .other(let pangoWeight): return pangoWeight
        }
    }
}

extension PangoWeight: Sendable, Equatable, Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.cPangoWeight.rawValue)
    }
}
