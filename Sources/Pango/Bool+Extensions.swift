//
//  Bool+Extensions.swift
//  
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

extension Bool
{
    public init(_ gboolean: gboolean)
    {
        self = gboolean != 0
    }

    public var gboolean: gboolean
    {
        return self ? 1 : 0
    }
}
