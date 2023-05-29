//
//  PangoCairoLayout.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import Cairo
import CPango

public final class PangoCairoLayout: PangoLayout
{
    public init(cairoContext: Cairo.Context)
    {
        let internalPointer = cairoContext.withUnsafeOpaquePointer
        {
            (cairoPointer) in
            guard let internalPointer = pango_cairo_create_layout(cairoPointer) else
            {
                fatalError("pango_cairo_create_layout() failed.")
            }
            return internalPointer
        }
        super.init(internalPointer: internalPointer)
        g_object_unref(internalPointer)
    }
    
    internal override init(internalPointer: UnsafeMutablePointer<CPango.PangoLayout>)
    {
        super.init(internalPointer: internalPointer)
    }

    public override init(context: PangoContext)
    {
        super.init(context: context)
    }

    public override init(copying layout: PangoLayout)
    {
        super.init(copying: layout)
    }

    public func show(in context: Cairo.Context)
    {
        context.withUnsafeOpaquePointer
        {
            (cairoPointer) in
            pango_cairo_show_layout(cairoPointer, self.internalPointer)
        }
    }

    public func addToPath(in context: Cairo.Context)
    {
        context.withUnsafeOpaquePointer
        {
            (cairoPointer) in
            pango_cairo_layout_path(cairoPointer, self.internalPointer)
        }
    }
}
