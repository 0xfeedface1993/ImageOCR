//
//  File.swift
//  
//
//  Created by john on 2023/9/11.
//

import Foundation
import CImageMagick

public enum ImageMagickColorSpace {
    case UndefinedColorspace
    case CMYColorspace
    case CMYKColorspace
    case GRAYColorspace
    case HCLColorspace
    case HCLpColorspace
    case HSBColorspace
    case HSIColorspace
    case HSLColorspace
    case HSVColorspace
    case HWBColorspace
    case LabColorspace
    case LCHColorspace
    case LCHabColorspace
    case LCHuvColorspace
    case LogColorspace
    case LMSColorspace
    case LuvColorspace
    case OHTAColorspace
    case Rec601YCbCrColorspace
    case Rec709YCbCrColorspace
    case RGBColorspace
    case scRGBColorspace
    case sRGBColorspace
    case TransparentColorspace
    case xyYColorspace
    case XYZColorspace
    case YCbCrColorspace
    case YCCColorspace
    case YDbDrColorspace
    case YIQColorspace
    case YPbPrColorspace
    case YUVColorspace
    case LinearGRAYColorspace
    case JzazbzColorspace
    case DisplayP3Colorspace
    case Adobe98Colorspace
    case ProPhotoColorspace
    case OklabColorspace
    case OklchColorspace
    
    init(_ colorSpace: ColorspaceType) {
        switch colorSpace {
        case CImageMagick.UndefinedColorspace:
            self = .UndefinedColorspace
        case CImageMagick.CMYColorspace:
            self = .CMYColorspace
        case CImageMagick.CMYKColorspace:
            self = .CMYKColorspace
        case CImageMagick.GRAYColorspace:
            self = .GRAYColorspace
        case CImageMagick.HCLColorspace:
            self = .HCLColorspace
        case CImageMagick.HCLpColorspace:
            self = .HCLpColorspace
        case CImageMagick.HSBColorspace:
            self = .HSBColorspace
        case CImageMagick.HSIColorspace:
            self = .HSIColorspace
        case CImageMagick.HSLColorspace:
            self = .HSLColorspace
        case CImageMagick.HSVColorspace:
            self = .HSVColorspace
        case CImageMagick.HWBColorspace:
            self = .HWBColorspace
        case CImageMagick.LabColorspace:
            self = .LabColorspace
        case CImageMagick.LCHColorspace:
            self = .LCHColorspace
        case CImageMagick.LCHabColorspace:
            self = .LCHabColorspace
        case CImageMagick.LCHuvColorspace:
            self = .LCHuvColorspace
        case CImageMagick.LogColorspace:
            self = .LogColorspace
        case CImageMagick.LMSColorspace:
            self = .LMSColorspace
        case CImageMagick.LuvColorspace:
            self = .LuvColorspace
        case CImageMagick.OHTAColorspace:
            self = .OHTAColorspace
        case CImageMagick.Rec601YCbCrColorspace:
            self = .Rec601YCbCrColorspace
        case CImageMagick.Rec709YCbCrColorspace:
            self = .Rec709YCbCrColorspace
        case CImageMagick.RGBColorspace:
            self = .RGBColorspace
        case CImageMagick.scRGBColorspace:
            self = .scRGBColorspace
        case CImageMagick.sRGBColorspace:
            self = .sRGBColorspace
        case CImageMagick.TransparentColorspace:
            self = .TransparentColorspace
        case CImageMagick.xyYColorspace:
            self = .xyYColorspace
        case CImageMagick.XYZColorspace:
            self = .XYZColorspace
        case CImageMagick.YCbCrColorspace:
            self = .YCbCrColorspace
        case CImageMagick.YCCColorspace:
            self = .YCCColorspace
        case CImageMagick.YDbDrColorspace:
            self = .YDbDrColorspace
        case CImageMagick.YIQColorspace:
            self = .YIQColorspace
        case CImageMagick.YPbPrColorspace:
            self = .YPbPrColorspace
        case CImageMagick.YUVColorspace:
            self = .YUVColorspace
        case CImageMagick.LinearGRAYColorspace:
            self = .LinearGRAYColorspace
        case CImageMagick.JzazbzColorspace:
            self = .JzazbzColorspace
        case CImageMagick.DisplayP3Colorspace:
            self = .DisplayP3Colorspace
        case CImageMagick.Adobe98Colorspace:
            self = .Adobe98Colorspace
        case CImageMagick.ProPhotoColorspace:
            self = .ProPhotoColorspace
        case CImageMagick.OklabColorspace:
            self = .OklabColorspace
        case CImageMagick.OklchColorspace:
            self = .OklchColorspace
        default:
            self = .UndefinedColorspace
        }
    }
    
    var rawValue: CImageMagick.ColorspaceType {
        switch self {
        case .UndefinedColorspace:
            return CImageMagick.UndefinedColorspace
        case .CMYColorspace:
            return CImageMagick.CMYColorspace
        case .CMYKColorspace:
            return CImageMagick.CMYKColorspace
        case .GRAYColorspace:
            return CImageMagick.GRAYColorspace
        case .HCLColorspace:
            return CImageMagick.HCLColorspace
        case .HCLpColorspace:
            return CImageMagick.HCLpColorspace
        case .HSBColorspace:
            return CImageMagick.HSBColorspace
        case .HSIColorspace:
            return CImageMagick.HSIColorspace
        case .HSLColorspace:
            return CImageMagick.HSLColorspace
        case .HSVColorspace:
            return CImageMagick.HSVColorspace
        case .HWBColorspace:
            return CImageMagick.HWBColorspace
        case .LabColorspace:
            return CImageMagick.LabColorspace
        case .LCHColorspace:
            return CImageMagick.LCHColorspace
        case .LCHabColorspace:
            return CImageMagick.LCHabColorspace
        case .LCHuvColorspace:
            return CImageMagick.LCHuvColorspace
        case .LogColorspace:
            return CImageMagick.LogColorspace
        case .LMSColorspace:
            return CImageMagick.LMSColorspace
        case .LuvColorspace:
            return CImageMagick.LuvColorspace
        case .OHTAColorspace:
            return CImageMagick.OHTAColorspace
        case .Rec601YCbCrColorspace:
            return CImageMagick.Rec601YCbCrColorspace
        case .Rec709YCbCrColorspace:
            return CImageMagick.Rec709YCbCrColorspace
        case .RGBColorspace:
            return CImageMagick.RGBColorspace
        case .scRGBColorspace:
            return CImageMagick.scRGBColorspace
        case .sRGBColorspace:
            return CImageMagick.sRGBColorspace
        case .TransparentColorspace:
            return CImageMagick.TransparentColorspace
        case .xyYColorspace:
            return CImageMagick.xyYColorspace
        case .XYZColorspace:
            return CImageMagick.XYZColorspace
        case .YCbCrColorspace:
            return CImageMagick.YCbCrColorspace
        case .YCCColorspace:
            return CImageMagick.YCCColorspace
        case .YDbDrColorspace:
            return CImageMagick.YDbDrColorspace
        case .YIQColorspace:
            return CImageMagick.YIQColorspace
        case .YPbPrColorspace:
            return CImageMagick.YPbPrColorspace
        case .YUVColorspace:
            return CImageMagick.YUVColorspace
        case .LinearGRAYColorspace:
            return CImageMagick.LinearGRAYColorspace
        case .JzazbzColorspace:
            return CImageMagick.JzazbzColorspace
        case .DisplayP3Colorspace:
            return CImageMagick.DisplayP3Colorspace
        case .Adobe98Colorspace:
            return CImageMagick.Adobe98Colorspace
        case .ProPhotoColorspace:
            return CImageMagick.ProPhotoColorspace
        case .OklabColorspace:
            return CImageMagick.OklabColorspace
        case .OklchColorspace:
            return CImageMagick.OklchColorspace
        }
    }
}
