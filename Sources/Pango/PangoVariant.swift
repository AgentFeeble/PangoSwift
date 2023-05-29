//
//  PangoVariant.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoVariant
{
    case normal
    case smallCaps
    case allSmallCaps
    case petiteCaps
    case allPetiteCaps
    case unicase
    case titleCaps
    case other(CPango.PangoVariant)

    init(cPangoVariant: CPango.PangoVariant)
    {
        switch cPangoVariant
        {
        case PANGO_VARIANT_NORMAL:
            self = .normal

        case PANGO_VARIANT_SMALL_CAPS:
            self = .smallCaps

        case PANGO_VARIANT_ALL_SMALL_CAPS:
            self = .allSmallCaps

        case PANGO_VARIANT_PETITE_CAPS:
            self = .petiteCaps

        case PANGO_VARIANT_ALL_PETITE_CAPS:
            self = .allPetiteCaps

        case PANGO_VARIANT_UNICASE:
            self = .unicase

        case PANGO_VARIANT_TITLE_CAPS:
            self = .titleCaps

        default:
            self = .other(cPangoVariant)
        }
    }

    public var cPangoVariant: CPango.PangoVariant
    {
        switch self
        {
        case .normal: return PANGO_VARIANT_NORMAL
        case .smallCaps: return PANGO_VARIANT_SMALL_CAPS
        case .allSmallCaps: return PANGO_VARIANT_ALL_SMALL_CAPS
        case .petiteCaps: return PANGO_VARIANT_PETITE_CAPS
        case .allPetiteCaps: return PANGO_VARIANT_ALL_PETITE_CAPS
        case .unicase: return PANGO_VARIANT_UNICASE
        case .titleCaps: return PANGO_VARIANT_TITLE_CAPS
        case .other(let variant): return variant
        }
    }
}

extension PangoVariant: Sendable, Equatable, Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.cPangoVariant.rawValue)
    }
}
