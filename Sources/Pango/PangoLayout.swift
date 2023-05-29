//
//  PangoLayout.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/28.
//

import CPango
import Foundation

public class PangoLayout: UnsafeMutablePointerOwner
{
    public typealias Pointee = CPango.PangoLayout

    var internalPointer: UnsafeMutablePointer<CPango.PangoLayout>

    internal init(internalPointer: UnsafeMutablePointer<CPango.PangoLayout>)
    {
        g_object_ref(internalPointer)
        self.internalPointer = internalPointer
    }

    public init(context: PangoContext)
    {
        guard let internalPointer = pango_layout_new(context.internalPointer) else
        {
            fatalError("pango_layout_new() failed.")
        }
        self.internalPointer = internalPointer
    }

    public init(copying layout: PangoLayout)
    {
        guard let internalPointer = pango_layout_copy(layout.internalPointer) else
        {
            fatalError("pango_layout_copy() failed.")
        }
        self.internalPointer = internalPointer
    }

    public var context: PangoContext
    {
        guard let internalContextPointer = pango_layout_get_context(self.internalPointer) else
        {
            fatalError("nil context returned from pango_layout_get_context()")
        }
        return PangoContext(internalPointer: internalContextPointer)
    }

    public var text: String
    {
        get
        {
            guard let cString = pango_layout_get_text(self.internalPointer) else
            {
                fatalError("Expected non-nil return type from pango_layout_get_text().")
            }
            guard let text = String(utf8String: cString) else
            {
                fatalError("Non UTF-8 text returned from pango_layout_get_text().")
            }
            return text
        }

        set
        {
            let stringLength = Int32(newValue.lengthOfBytes(using: .utf8))
            newValue.withCString { pango_layout_set_text(self.internalPointer, $0, stringLength) }
        }
    }

    public var maxWidth: MaxWidth
    {
        get
        {
            let units = pango_layout_get_width(self.internalPointer)
            return MaxWidth(pangoIntValue: units)
        }

        set
        {
            pango_layout_set_width(self.internalPointer, newValue.pangoIntValue)
        }
    }

    public var maxHeight: MaxHeight
    {
        get
        {
            let units = pango_layout_get_height(self.internalPointer)
            return MaxHeight(pangoIntValue: units)
        }

        set
        {
            pango_layout_set_height(self.internalPointer, newValue.pangoIntValue)
        }
    }

    public var wrap: PangoWrapMode
    {
        get
        {
            let wrap = pango_layout_get_wrap(self.internalPointer)
            return PangoWrapMode(cPangoWrapMode: wrap)
        }

        set
        {
            pango_layout_set_wrap(self.internalPointer, newValue.cPangoWrapMode)
        }
    }

    public var textIsWrappedForCurrentState: Bool
    {
        return pango_layout_is_wrapped(self.internalPointer) != 0
    }

    public var indent: Int32
    {
        get { pango_layout_get_indent(self.internalPointer) }
        set { pango_layout_set_indent(self.internalPointer, newValue) }
    }

    public var lineSpacing: Int32
    {
        get { pango_layout_get_spacing(self.internalPointer) }
        set { pango_layout_set_spacing(self.internalPointer, newValue) }
    }

    public var lineSpacingFactor: Float
    {
        get { pango_layout_get_line_spacing(self.internalPointer) }
        set { pango_layout_set_line_spacing(self.internalPointer, newValue) }
    }

    public var justify: Bool
    {
        get { pango_layout_get_justify(self.internalPointer) != 0 }
        set { pango_layout_set_justify(self.internalPointer, newValue ? 1 : 0) }
    }

    public var justifyLastLine: Bool
    {
        get { pango_layout_get_justify_last_line(self.internalPointer) != 0 }
        set { pango_layout_set_justify_last_line(self.internalPointer, newValue ? 1 : 0) }
    }

    public var autoInferTextDirection: Bool
    {
        get { pango_layout_get_auto_dir(self.internalPointer) != 0 }
        set { pango_layout_set_auto_dir(self.internalPointer, newValue ? 1 : 0) }
    }

    public var alignment: PangoAlignment
    {
        get
        {
            let alignment = pango_layout_get_alignment(self.internalPointer)
            return PangoAlignment(cPangoAlignment: alignment)
        }

        set
        {
            pango_layout_set_alignment(self.internalPointer, newValue.cPangoAlignment)
        }
    }

    public var singleParagraphMode: Bool
    {
        get { pango_layout_get_single_paragraph_mode(self.internalPointer) != 0 }
        set { pango_layout_set_single_paragraph_mode(self.internalPointer, newValue ? 1 : 0) }
    }

    public var ellipsizeMode: PangoEllipsizeMode
    {
        get
        {
            let mode = pango_layout_get_ellipsize(self.internalPointer)
            return PangoEllipsizeMode(cPangoEllipsizeMode: mode)
        }

        set
        {
            pango_layout_set_ellipsize(self.internalPointer, newValue.cPangoEllipsizeMode)
        }
    }

    public var textIsEllipsizedForCurrentState: Bool
    {
        return pango_layout_is_ellipsized(self.internalPointer) != 0
    }

    public func updateLayout(cairoPointer: OpaquePointer)
    {
        pango_cairo_update_layout(cairoPointer, self.internalPointer)
    }

    public func countNumberOfUnknownGlyphs() -> Int32
    {
        return pango_layout_get_unknown_glyphs_count(self.internalPointer)
    }

    public func getExtents() -> (inkRect: PangoRectangle, logicalRect: PangoRectangle)
    {
        var inkRect = PangoRectangle()
        var logicalRect = PangoRectangle()
        pango_layout_get_extents(self.internalPointer, &inkRect, &logicalRect)

        return (inkRect, logicalRect)
    }

    public func getInkRect() -> PangoRectangle
    {
        var inkRect = PangoRectangle()
        pango_layout_get_extents(self.internalPointer, &inkRect, nil)

        return inkRect
    }

    public func getLogicalRect() -> PangoRectangle
    {
        var logicalRect = PangoRectangle()
        pango_layout_get_extents(self.internalPointer, nil, &logicalRect)

        return logicalRect
    }

    public func getPixelExtents() -> (inkRect: PangoRectangle, logicalRect: PangoRectangle)
    {
        var inkRect = PangoRectangle()
        var logicalRect = PangoRectangle()
        pango_layout_get_pixel_extents(self.internalPointer, &inkRect, &logicalRect)

        return (inkRect, logicalRect)
    }

    public func getPixelInkRect() -> PangoRectangle
    {
        var inkRect = PangoRectangle()
        pango_layout_get_pixel_extents(self.internalPointer, &inkRect, nil)

        return inkRect
    }

    public func getPixelLogicalRect() -> PangoRectangle
    {
        var logicalRect = PangoRectangle()
        pango_layout_get_pixel_extents(self.internalPointer, nil, &logicalRect)

        return logicalRect
    }

    public func getSize() -> (width: Int32, height: Int32)
    {
        var width: Int32 = 0
        var height: Int32 = 0
        pango_layout_get_size(self.internalPointer, &width, &height)

        return (width, height)
    }

    public func getWidth() -> Int32
    {
        var width: Int32 = 0
        pango_layout_get_size(self.internalPointer, &width, nil)

        return width
    }

    public func getHeight() -> Int32
    {
        var height: Int32 = 0
        pango_layout_get_size(self.internalPointer, nil, &height)

        return height
    }

    public func getPixelSize() -> (width: Int32, height: Int32)
    {
        var width: Int32 = 0
        var height: Int32 = 0
        pango_layout_get_pixel_size(self.internalPointer, &width, &height)

        return (width, height)
    }

    public func getPixelWidth() -> Int32
    {
        var width: Int32 = 0
        pango_layout_get_pixel_size(self.internalPointer, &width, nil)

        return width
    }

    public func getPixelHeight() -> Int32
    {
        var height: Int32 = 0
        pango_layout_get_pixel_size(self.internalPointer, nil, &height)

        return height
    }

    public func getLineCount() -> Int32
    {
        return pango_layout_get_line_count(self.internalPointer)
    }
}

extension PangoLayout
{
    public enum MaxWidth: Equatable, Hashable
    {
        /// The width is not limited
        case none
        case maxPangoUnits(Int32)

        public init(pangoIntValue: Int32)
        {
            self = pangoIntValue == -1 ? .none : .maxPangoUnits(pangoIntValue)
        }

        public var pangoIntValue: Int32
        {
            switch self
            {
            case .none:
                return -1

            case .maxPangoUnits(let units):
                return max(1, units)
            }
        }
    }

    public enum MaxHeight: Equatable, Hashable
    {
        /// The text will only occupy a single line
        case singleLine
        /// The maximum height of the layout is bounded by this integer value. The layout will always have enough height
        /// for at least 1 line of text.
        case maxPangoUnits(Int32)
        /// The maximum number of lines in each paragraph of text
        case maxLinesPerParagraph(Int32)

        public init(pangoIntValue: Int32)
        {
            switch pangoIntValue
            {
            case 0:
                self = .singleLine

            case let x where x > 0:
                self = .maxPangoUnits(pangoIntValue)

            default:
                self = .maxLinesPerParagraph(-pangoIntValue)
            }
        }

        public var pangoIntValue: Int32
        {
            switch self
            {
            case .singleLine:
                return 0

            case .maxPangoUnits(let units):
                return max(1, units)

            case .maxLinesPerParagraph(let lines):
                return -max(1, lines)
            }
        }
    }
}
