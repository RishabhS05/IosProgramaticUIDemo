//
//  ErrorMessages.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import Foundation

enum GPTError : String , Error // raw values
{
    case usernameInvalid  = "This username created invalid request. Please try again"
    case checkInternet    = "Unable to call api please chack the internet connection."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case serverDataInvalid = "This data from the server is invalid. Please try again."
    
}
