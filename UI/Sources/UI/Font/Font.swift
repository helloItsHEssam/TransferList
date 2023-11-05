//
//  Font.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import CoreGraphics
import CoreText

public struct Font {
    
    // MARK: - Error
    private enum FontError: Error, LocalizedError {
        case cannotRegisterFont(fontName: String)
        case cannotUnRegisterFont(fontName: String)
        
        var errorDescription: String? {
            switch self {
            case .cannotRegisterFont(let fontName):
                return "Error registering font: \(fontName)"
                
            case .cannotUnRegisterFont(let fontName):
                return "Error unRegistering font: \(fontName)"
            }
        }
    }
    
    // MARK: - public methods
    public static func registerFonts() {
        
        Raleway.allCases.forEach { font in
            let name = String(describing: font)
            do {
               try registerFont(fontName: name, withExtension: font.fileExtension)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public static func unRegisterFonts() {
        
        Raleway.allCases.forEach { font in
            let name = String(describing: font)
            do {
               try unRegisterFont(fontName: name, withExtension: font.fileExtension)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - internal methods
    static func registerFont(fontName: String, withExtension: String) throws {

        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: withExtension) else {
            throw FontError.cannotRegisterFont(fontName: fontName)
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            throw FontError.cannotRegisterFont(fontName: fontName)
        }

        guard let font = CGFont(fontDataProvider) else {
            throw FontError.cannotRegisterFont(fontName: fontName)
        }

        let success = CTFontManagerRegisterGraphicsFont(font, nil)
        guard success else {
            throw FontError.cannotRegisterFont(fontName: fontName)
        }
    }
    
    static func unRegisterFont(fontName: String, withExtension: String) throws {

        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: withExtension) else {
            throw FontError.cannotUnRegisterFont(fontName: fontName)
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            throw FontError.cannotUnRegisterFont(fontName: fontName)
        }

        guard let font = CGFont(fontDataProvider) else {
            throw FontError.cannotUnRegisterFont(fontName: fontName)
        }

        let success = CTFontManagerUnregisterGraphicsFont(font, nil)
        guard success else {
            throw FontError.cannotUnRegisterFont(fontName: fontName)
        }
    }
}

