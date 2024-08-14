//
//  Constants.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit

enum SfSymbols {
    static let location               = UIImage (systemName:"mappin.and.ellipse" )
    static let repos                  = UIImage (systemName: "folder" )
    static let gist                   = UIImage (systemName: "text.alignleft" )
    static let followers              = UIImage (systemName: "heart" )
    static let followings             = UIImage (systemName: "person.2")
    static let followersLabel        = "person.3"
    static let personLabel        = "person"
    static let ok        = "checkmark.circle"
    static let star        = "star"
    static let personSlash        = "person.slash"
    
}
enum Images {
    static let ghLogo                 = "gh-logo"
    static let placeholderImage       = "avatar-placeholder"
    static let emptyStatePlaceHolder  = "empty-state-logo"
}

 // handling small screen
enum ScreenSize{
    static let width                  = UIScreen.main.bounds.size.width
    static let height                 = UIScreen.main.bounds.size.height
    static let maxLength              = max(ScreenSize.width, ScreenSize.height)
    static let minLength              = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
    static let idiom                  = UIDevice.current.userInterfaceIdiom
    static let nativeScale            = UIScreen.main.nativeScale
    static let scale                  = UIScreen.main.scale
    static let isiphoneSE             = idiom == .phone && ScreenSize.maxLength == 558.0
    static let isiphone8Standard      = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiphone8Zoomed        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiphone8PluseStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiphone8PLusZoomed    = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiphoneX              = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiphoneXsMaxAndXr     = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                 = idiom == .pad && ScreenSize.maxLength   >= 558.0
     
    static func isiPhoneXAspectRatio() -> Bool { return isiphoneX || isiphoneXsMaxAndXr }

}
