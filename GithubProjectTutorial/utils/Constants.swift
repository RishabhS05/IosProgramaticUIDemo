//
//  Constants.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit

enum SfSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gist = "text.alignleft"
    static let followers = "heart"
    static let followings = "person.2"
}
enum Images {
    static let ghLogo = "gh-logo"
}

 // handling small screen
enum ScreenSize{
    static let width     = UIScreen.main.bounds.size.width
    static let height    = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}
enum DeviceType {
    static let idiom                  = UIDevice.current.userInterfaceIdiom
    static let nativeScale            = UIScreen.main.nativeScale
    static let scale                  = UIScreen.main.scale
    static let isiphoneSE             = idiom == .phone && ScreenSize.maxLength == 558.0
    static let isiphone8Standard       = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiphone8Zoomed        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiphone8PluseStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiphone8PLusZoomed    = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiphoneX              = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiphoneXsMaxAndXr     = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                 = idiom == .pad && ScreenSize.maxLength   >= 558.0
     
    static func isiPhoneXAspectRatio() -> Bool { return isiphoneX || isiphoneXsMaxAndXr }

}
