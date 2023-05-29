//
//  PangoFontDescription.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/29.
//

import CPango

public class PangoFontDescription: UnsafeMutablePointerOwner
{
    public typealias Pointee = CPango.PangoFontDescription

    internal var internalPointer: UnsafeMutablePointer<CPango.PangoFontDescription>

    deinit
    {
        pango_font_description_free(self.internalPointer)
    }

    public init()
    {
        guard let internalPointer = pango_font_description_new() else
        {
            fatalError("pango_font_description_new() failed")
        }
        self.internalPointer = internalPointer
    }

    public init(copying description: PangoFontDescription)
    {
        guard let internalPointer = pango_font_description_copy(description.internalPointer) else
        {
            fatalError("pango_font_description_copy() failed")
        }
        self.internalPointer = internalPointer
    }

    public init(string: String)
    {
        self.internalPointer = string.withCString
        {
            (cString) in
            guard let internalPointer = pango_font_description_from_string(cString) else
            {
                fatalError("pango_font_description_from_string() failed")
            }
            return internalPointer
        }
    }

    public convenience init(family: String, size: PangoFontSize)
    {
        self.init(string: "\(family) \(size.descriptionString)")
    }

    internal init(copying pointerToCopy: UnsafePointer<CPango.PangoFontDescription>)
    {
        guard let internalPointer = pango_font_description_copy(pointerToCopy) else
        {
            fatalError("pango_font_description_copy() failed")
        }
        self.internalPointer = internalPointer
    }

    public var family: String?
    {
        get
        {
            guard let family = pango_font_description_get_family(self.internalPointer) else
            {
                return nil
            }
            return String(cString: family)
        }

        set
        {
            guard let newValue else
            {
                pango_font_description_set_family(self.internalPointer, nil)
                return
            }
            newValue.withCString { pango_font_description_set_family(self.internalPointer, $0) }
        }
    }

    public var style: PangoStyle
    {
        get
        {
            let style = pango_font_description_get_style(self.internalPointer)
            return PangoStyle(cPangoStyle: style)
        }

        set
        {
            pango_font_description_set_style(self.internalPointer, newValue.cPangoStyle)
        }
    }

    public var variant: PangoVariant
    {
        get
        {
            let variant = pango_font_description_get_variant(self.internalPointer)
            return PangoVariant(cPangoVariant: variant)
        }

        set
        {
            pango_font_description_set_variant(self.internalPointer, newValue.cPangoVariant)
        }
    }

    public var weight: PangoWeight
    {
        get
        {
            let weight = pango_font_description_get_weight(self.internalPointer)
            return PangoWeight(cPangoWeight: weight)
        }

        set
        {
            pango_font_description_set_weight(self.internalPointer, newValue.cPangoWeight)
        }
    }

    public var stretch: PangoStretch
    {
        get
        {
            let stretch = pango_font_description_get_stretch(self.internalPointer)
            return PangoStretch(cPangoStretch: stretch)
        }

        set
        {
            pango_font_description_set_stretch(self.internalPointer, newValue.cPangoStretch)
        }
    }

    public var size: PangoFontSize
    {
        get
        {
            let size = pango_font_description_get_size(self.internalPointer)
            let isAbsolute = Bool(pango_font_description_get_size_is_absolute(self.internalPointer))
            if isAbsolute
            {
                return .pixels(Double(size))
            }
            return .points(size)
        }

        set
        {
            switch newValue
            {
            case .points(let pointSize):
                pango_font_description_set_size(self.internalPointer, pointSize)

            case .pixels(let pixelSize):
                pango_font_description_set_absolute_size(self.internalPointer, pixelSize)
            }
        }
    }

    public var sizeIsAbsolute: Bool
    {
        return Bool(pango_font_description_get_size_is_absolute(self.internalPointer))
    }

    public var gravity: PangoGravity
    {
        get
        {
            let gravity = pango_font_description_get_gravity(self.internalPointer)
            return PangoGravity(cPangoGravity: gravity)
        }

        set
        {
            pango_font_description_set_gravity(self.internalPointer, newValue.cPangoGravity)
        }
    }

    public var variations: String?
    {
        get
        {
            guard let variations = pango_font_description_get_variations(self.internalPointer) else
            {
                return nil
            }
            return String(cString: variations)
        }

        set
        {
            guard let newValue else
            {
                pango_font_description_set_variations(self.internalPointer, nil)
                return
            }
            newValue.withCString { pango_font_description_set_variations(self.internalPointer, $0) }
        }
    }

    public var setFields: PangoFontMask
    {
        get { PangoFontMask(pango_font_description_get_set_fields(self.internalPointer)) }
    }

    public var stringDescription: String
    {
        guard let description = pango_font_description_to_string(self.internalPointer) else
        {
            fatalError("pango_font_description_to_string() failed.")
        }
        return String(cString: description)
    }

    public var filenameDesscription: String
    {
        guard let description = pango_font_description_to_filename(self.internalPointer) else
        {
            fatalError("pango_font_description_to_filename() failed.")
        }
        return String(cString: description)
    }

    public func unset(fields: PangoFontMask)
    {
        pango_font_description_unset_fields(self.internalPointer, fields.cPangoFontMask)
    }

    public func merge(with fontDescription: PangoFontDescription, replaceExisting: Bool)
    {
        pango_font_description_merge(self.internalPointer, fontDescription.internalPointer, replaceExisting.gboolean)
    }

    public func checkBetterMatch(forOldMatch oldMatch: PangoFontDescription, newMatch: PangoFontDescription) -> Bool
    {
        return Bool(
            pango_font_description_better_match(
                self.internalPointer,
                oldMatch.internalPointer,
                newMatch.internalPointer
            )
        )
    }
}

extension PangoFontDescription
{
    public static func dumpAvailableFontInfo()
    {
        guard let fontMap = pango_cairo_font_map_get_default() else
        {
            print("pango_cairo_font_map_get_default() failed")
            return
        }

        var families: UnsafeMutablePointer<UnsafeMutablePointer<PangoFontFamily>?>? = nil
        var familyCount: Int32 = 0
        pango_font_map_list_families(fontMap, &families, &familyCount)

        guard let families else
        {
            print(familyCount == 0 ? "No fonts found." : "pango_font_map_list_families() failed.")
            return
        }
        defer { g_free(families) }

        var faces: UnsafeMutablePointer<UnsafeMutablePointer<PangoFontFace>?>? = nil
        var faceCount: Int32 = 0
        for family in UnsafeMutableBufferPointer(start: families, count: Int(familyCount))
        {
            let familyName = pango_font_family_get_name(family).map { String(cString: $0) } ?? "(unknown-family)"
            pango_font_family_list_faces(family, &faces, &faceCount)

            print(familyName)
            guard let faces else
            {
                if faceCount != 0
                {
                    print("pango_font_family_list_faces() failed for family \(familyName).")
                }
                continue
            }
            defer { g_free(faces) }

            for face in UnsafeMutableBufferPointer(start: faces, count: Int(faceCount))
            {
                let name = pango_font_face_get_face_name(face).map { String(cString: $0) } ?? "(unknown-face)"
                print("\t\(name)")
            }
        }
    }
}

extension PangoFontDescription: Equatable
{
    public static func == (lhs: PangoFontDescription, rhs: PangoFontDescription) -> Bool
    {
        return Bool(pango_font_description_equal(lhs.internalPointer, rhs.internalPointer))
    }
}
