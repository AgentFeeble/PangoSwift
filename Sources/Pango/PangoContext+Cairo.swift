//
//  PangoContext+Cairo.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import Cairo
import CPango

extension PangoContext
{
    public convenience init(cairoContext: Cairo.Context)
    {
        let internalPointer = cairoContext.withUnsafeOpaquePointer
        {
            (cairoPointer) in
            guard let internalPointer = pango_cairo_create_context(cairoPointer) else
            {
                fatalError("pango_cairo_create_context() failed.")
            }
            return internalPointer
        }
        self.init(internalPointer: internalPointer)
        g_object_unref(internalPointer)
    }
}
