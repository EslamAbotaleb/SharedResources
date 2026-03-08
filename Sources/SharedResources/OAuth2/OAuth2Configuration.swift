//
//  OAuth2Configuration.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/4/26.
//

/*
import Foundation
import UIKit

open class OAuth2Configuration {
  
  /// Other OAuth2 parameters.
  public var parameters: [String:String] = [:]
  
  /// The client id.
  private(set) public var clientId: String = ""
  
  /// The client secret, usually only needed for code grant (ex: Google).
  private(set) public var clientSecret: String = ""
  
  /// The scope currently in use.
  private(set) public var scope: String = ""
  
  /// The URL to authorize against.
  private(set) public var authURL: String = ""
  
  /// The URL string where we can exchange a code for a token.
  private(set) public var tokenURL: String = ""
  
  /// The redirect URL string to use.
  private(set) public var redirectURL: String = ""
  
  /// The response type expected from an authorize call, e.g. "code" for Google.
  private(set) public var responseType: String = "code"
  
private(set) public var codeChallenge: String = ""
private(set) public var codeVerifer: String = ""

  // SFSafariViewController configuration
  #if os(iOS)
  /// The SFSafariViewController title.
  public final var preferredTitle: String = ""
  
  /// The SFSafariViewController tintColor.
  public final var preferredBarTintColor: UIColor = UIColor.white
  
  /// The SFSafariViewController tintColor.
  public final var preferredTintColor: UIColor = UIColor.black
  
  /// The SFSafariViewController presentationStyle.
  public final var preferredPresentationStyle: UIModalPresentationStyle = UIModalPresentationStyle.formSheet
  #endif
  
    public init(clientId:String, clientSecret:String, authURL:String, tokenURL:String, scope:String, redirectURL:String,code_challenge:String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.authURL = authURL
        self.tokenURL = tokenURL
        self.scope = scope
        self.redirectURL = redirectURL
        self.codeChallenge = code_challenge
    }
  
    public init(clientId:String, authURL:String, tokenURL:String, scope:String, redirectURL:String, responseType:String,code_challenge:String,codeVerifier:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.scope = scope
    self.redirectURL = redirectURL
    self.responseType = responseType
    self.codeChallenge = code_challenge
    self.codeVerifer = codeVerifier
  }
  
  public init(clientId:String, authURL:String, tokenURL:String, scope:String, redirectURL:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.scope = scope
    self.redirectURL = redirectURL
  }
  
  public init(clientId:String, authURL:String, tokenURL:String, redirectURL:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.redirectURL = redirectURL
  }
  
  public init() {
    
  }
  
}
*/
