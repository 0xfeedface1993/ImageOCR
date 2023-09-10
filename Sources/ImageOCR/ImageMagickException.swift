//
//  File.swift
//  
//
//  Created by john on 2023/9/11.
//

import Foundation
import CImageMagick

enum ImageMagickException {
    case UndefinedException
    case WarningException
    case ResourceLimitWarning
    case TypeWarning
    case OptionWarning
    case DelegateWarning
    case MissingDelegateWarning
    case CorruptImageWarning
    case FileOpenWarning
    case BlobWarning
    case StreamWarning
    case CacheWarning
    case CoderWarning
    case FilterWarning
    case ModuleWarning
    case DrawWarning
    case ImageWarning
    case WandWarning
    case RandomWarning
    case XServerWarning
    case MonitorWarning
    case RegistryWarning
    case ConfigureWarning
    case PolicyWarning
    case ErrorException
    case ResourceLimitError
    case TypeError
    case OptionError
    case DelegateError
    case MissingDelegateError
    case CorruptImageError
    case FileOpenError
    case BlobError
    case StreamError
    case CacheError
    case CoderError
    case FilterError
    case ModuleError
    case DrawError
    case ImageError
    case WandError
    case RandomError
    case XServerError
    case MonitorError
    case RegistryError
    case ConfigureError
    case PolicyError
    case FatalErrorException
    case ResourceLimitFatalError
    case TypeFatalError
    case OptionFatalError
    case DelegateFatalError
    case MissingDelegateFatalError
    case CorruptImageFatalError
    case FileOpenFatalError
    case BlobFatalError
    case StreamFatalError
    case CacheFatalError
    case CoderFatalError
    case FilterFatalError
    case ModuleFatalError
    case DrawFatalError
    case ImageFatalError
    case WandFatalError
    case RandomFatalError
    case XServerFatalError
    case MonitorFatalError
    case RegistryFatalError
    case ConfigureFatalError
    case PolicyFatalError
    
    case invalidFileSystemRepresentation(URL)
    
    init(_ exception: CImageMagick.ExceptionType) {
        switch exception {
        case CImageMagick.UndefinedException:
            self = .UndefinedException
        case CImageMagick.WarningException:
            self = .WarningException
        case CImageMagick.ResourceLimitWarning:
            self = .ResourceLimitWarning
        case CImageMagick.TypeWarning:
            self = .TypeWarning
        case CImageMagick.OptionWarning:
            self = .OptionWarning
        case CImageMagick.DelegateWarning:
            self = .DelegateWarning
        case CImageMagick.MissingDelegateWarning:
            self = .MissingDelegateWarning
        case CImageMagick.CorruptImageWarning:
            self = .CorruptImageWarning
        case CImageMagick.FileOpenWarning:
            self = .FileOpenWarning
        case CImageMagick.BlobWarning:
            self = .BlobWarning
        case CImageMagick.StreamWarning:
            self = .StreamWarning
        case CImageMagick.CacheWarning:
            self = .CacheWarning
        case CImageMagick.CoderWarning:
            self = .CoderWarning
        case CImageMagick.FilterWarning:
            self = .FilterWarning
        case CImageMagick.ModuleWarning:
            self = .ModuleWarning
        case CImageMagick.DrawWarning:
            self = .DrawWarning
        case CImageMagick.ImageWarning:
            self = .ImageWarning
        case CImageMagick.WandWarning:
            self = .WandWarning
        case CImageMagick.RandomWarning:
            self = .RandomWarning
        case CImageMagick.XServerWarning:
            self = .XServerWarning
        case CImageMagick.MonitorWarning:
            self = .MonitorWarning
        case CImageMagick.RegistryWarning:
            self = .RegistryWarning
        case CImageMagick.ConfigureWarning:
            self = .ConfigureWarning
        case CImageMagick.PolicyWarning:
            self = .PolicyWarning
        case CImageMagick.ErrorException:
            self = .ErrorException
        case CImageMagick.ResourceLimitError:
            self = .ResourceLimitError
        case CImageMagick.TypeError:
            self = .TypeError
        case CImageMagick.OptionError:
            self = .OptionError
        case CImageMagick.DelegateError:
            self = .DelegateError
        case CImageMagick.MissingDelegateError:
            self = .MissingDelegateError
        case CImageMagick.CorruptImageError:
            self = .CorruptImageError
        case CImageMagick.FileOpenError:
            self = .FileOpenError
        case CImageMagick.BlobError:
            self = .BlobError
        case CImageMagick.StreamError:
            self = .StreamError
        case CImageMagick.CacheError:
            self = .CacheError
        case CImageMagick.CoderError:
            self = .CoderError
        case CImageMagick.FilterError:
            self = .FilterError
        case CImageMagick.ModuleError:
            self = .ModuleError
        case CImageMagick.DrawError:
            self = .DrawError
        case CImageMagick.ImageError:
            self = .ImageError
        case CImageMagick.WandError:
            self = .WandError
        case CImageMagick.RandomError:
            self = .RandomError
        case CImageMagick.XServerError:
            self = .XServerError
        case CImageMagick.MonitorError:
            self = .MonitorError
        case CImageMagick.RegistryError:
            self = .RegistryError
        case CImageMagick.ConfigureError:
            self = .ConfigureError
        case CImageMagick.PolicyError:
            self = .PolicyError
        case CImageMagick.FatalErrorException:
            self = .FatalErrorException
        case CImageMagick.ResourceLimitFatalError:
            self = .ResourceLimitFatalError
        case CImageMagick.TypeFatalError:
            self = .TypeFatalError
        case CImageMagick.OptionFatalError:
            self = .OptionFatalError
        case CImageMagick.DelegateFatalError:
            self = .DelegateFatalError
        case CImageMagick.MissingDelegateFatalError:
            self = .MissingDelegateFatalError
        case CImageMagick.CorruptImageFatalError:
            self = .CorruptImageFatalError
        case CImageMagick.FileOpenFatalError:
            self = .FileOpenFatalError
        case CImageMagick.BlobFatalError:
            self = .BlobFatalError
        case CImageMagick.StreamFatalError:
            self = .StreamFatalError
        case CImageMagick.CacheFatalError:
            self = .CacheFatalError
        case CImageMagick.CoderFatalError:
            self = .CoderFatalError
        case CImageMagick.FilterFatalError:
            self = .FilterFatalError
        case CImageMagick.ModuleFatalError:
            self = .ModuleFatalError
        case CImageMagick.DrawFatalError:
            self = .DrawFatalError
        case CImageMagick.ImageFatalError:
            self = .ImageFatalError
        case CImageMagick.WandFatalError:
            self = .WandFatalError
        case CImageMagick.RandomFatalError:
            self = .RandomFatalError
        case CImageMagick.XServerFatalError:
            self = .XServerFatalError
        case CImageMagick.MonitorFatalError:
            self = .MonitorFatalError
        case CImageMagick.RegistryFatalError:
            self = .RegistryFatalError
        case CImageMagick.ConfigureFatalError:
            self = .ConfigureFatalError
        case CImageMagick.PolicyFatalError:
            self = .PolicyFatalError
        default:
            self = .UndefinedException
        }
    }
}

