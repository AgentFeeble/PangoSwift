//
//  PangoGravity.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public enum PangoGravity
{
    case south
    case east
    case north
    case west
    case auto
    case other(CPango.PangoGravity)

    init(cPangoGravity: CPango.PangoGravity)
    {
        switch cPangoGravity
        {
        case PANGO_GRAVITY_SOUTH:
            self = .south

        case PANGO_GRAVITY_EAST:
            self = .east

        case PANGO_GRAVITY_NORTH:
            self = .north

        case PANGO_GRAVITY_WEST:
            self = .west

        case PANGO_GRAVITY_AUTO:
            self = .auto

        default:
            self = .other(cPangoGravity)
        }
    }

    public var cPangoGravity: CPango.PangoGravity
    {
        switch self
        {
        case .south: return PANGO_GRAVITY_SOUTH
        case .east: return PANGO_GRAVITY_EAST
        case .north: return PANGO_GRAVITY_NORTH
        case .west: return PANGO_GRAVITY_WEST
        case .auto: return PANGO_GRAVITY_AUTO
        case .other(let pangoGravity): return pangoGravity
        }
    }
}

extension PangoGravity: Sendable, Equatable, Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.cPangoGravity.rawValue)
    }
}
