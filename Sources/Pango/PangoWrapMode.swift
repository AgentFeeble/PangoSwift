//
//  PangoWrapMode.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/28.
//

import CPango

public enum PangoWrapMode
{
    case word
    case character
    case wordAndCharacter
    case other(CPango.PangoWrapMode)

    init(cPangoWrapMode: CPango.PangoWrapMode)
    {
        switch cPangoWrapMode
        {
        case PANGO_WRAP_WORD:
            self = .word

        case PANGO_WRAP_CHAR:
            self = .character

        case PANGO_WRAP_WORD_CHAR:
            self = .wordAndCharacter

        default:
            self = .other(cPangoWrapMode)
        }
    }

    public var cPangoWrapMode: CPango.PangoWrapMode
    {
        switch self
        {
        case .word: return PANGO_WRAP_WORD
        case .character: return PANGO_WRAP_CHAR
        case .wordAndCharacter: return PANGO_WRAP_WORD_CHAR
        case .other(let wrap): return wrap
        }
    }
}
