//
//  PangoContext.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/28.
//

import CPango

public final class PangoContext: UnsafeMutablePointerOwner
{
    public typealias Pointee = CPango.PangoContext

    internal let internalPointer: UnsafeMutablePointer<CPango.PangoContext>

    deinit
    {
        g_object_unref(self.internalPointer)
    }

    /// This method will retain `internalPointer`, and release it in `deinit`
    internal init(internalPointer: UnsafeMutablePointer<CPango.PangoContext>)
    {
        g_object_ref(internalPointer)
        self.internalPointer = internalPointer
    }
}
