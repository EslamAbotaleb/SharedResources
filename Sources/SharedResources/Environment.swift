//
//  Environment.swift
//  CERQEL
//
//  Created by iSlam on 10/6/20.
//  Copyright © 2020 Youxel. All rights reserved.
//

import Foundation

public enum cerqel_Environment {
    // MARK: - Keys
    public enum Keys {
        public enum Plist {
            public static let API_Base_URL = "API_Base_URL"
            public static let loginClientId = "client_id"
            public static let authConfigRedirectionUri = "Auth_Config_Redirection_Uri"
            public static let authConfigAuthorizationUri = "Auth_Config_Authorization_Uri"
            public static let authConfigTokenUri = "Auth_Config_Token_Uri"
            public static let loginClientSecret = "client_secret"
            public static let loginIV = "iv"
            public static let Share_Link_URL = "Share_Link_URL"
            public static let encryptionKey = "encryptionKey"
            public static let CONTENT_Base_URL = "CONTENT_Base_URL"
            public static let Self_Service_URL = "Self_Service_URL"
            public static let User_Manager_URL = "User_Manager_URL"
            public static let Notification_Base_URL = "Notification_Base_URL"
            public static let FileManager_Base_URL = "FileManager_Base_URL"
            public static let Mocking_Base_URL = "Mocking_Base_URL"
            public static let appCenterKey = "appCenterKey"
            public static let Search_Base_URL = "Search_Base_URL"
            public static let bundleIdeneifier: String = "PRODUCT_BUNDLE_IDENTIFIER"

        }
        
    }
    
    // Checking Environment PreDev
    static public var isPreDev: Bool {
        return Api_Base_URL.contains("/predev/")
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static public let Api_Base_URL: String = {
        guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.API_Base_URL] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
        
    static public let loginClientId: String = {
        guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.loginClientId] as? String else {
            fatalError("loginClientId Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static public let authConfigRedirectionUri: String = {
        guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.authConfigRedirectionUri] as? String else {
            fatalError("authConfigRedirectionUri Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static public let authConfigAuthorizationUri: String = {
        guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.authConfigAuthorizationUri] as? String else {
            fatalError("authConfigAuthorizationUri Key not set in plist for this environment")
        }
        return apiKey
    }()

    public struct EnvironmentConfig {
        public static let authConfigTokenUri: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.authConfigTokenUri] as? String else {
                fatalError("authConfigTokenUri Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let loginClientSecret: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.loginClientSecret] as? String else {
                fatalError("loginClientSecret Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let loginIV: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.loginIV] as? String else {
                fatalError("IV Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let encryptionKey: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.encryptionKey] as? String else {
                fatalError("encryptionKey Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let CONTENT_Base_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.CONTENT_Base_URL] as? String else {
                fatalError("CONTENT_Base_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let Search_Base_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.Search_Base_URL] as? String else {
                fatalError("Search_Base_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let Self_Service_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.Self_Service_URL] as? String else {
                fatalError("Self_Service_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let User_Manager_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.User_Manager_URL] as? String else {
                fatalError("User_Manager_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let Notification_Base_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.Notification_Base_URL] as? String else {
                fatalError("Notification_Base_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let FileManager_Base_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.FileManager_Base_URL] as? String else {
                fatalError("FileManager_Base_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let Mocking_Base_URL: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.Mocking_Base_URL] as? String else {
                fatalError("Mocking_Base_URL Key not set in plist for this environment")
            }
            return apiKey
        }()

        public static let appCenterKey: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.appCenterKey] as? String else {
                fatalError("appCenterKey Key not set in plist for this environment")
            }
            return apiKey
        }()
        
        public static let bundleIdentifier: String = {
            guard let apiKey = cerqel_Environment.infoDictionary[Keys.Plist.bundleIdeneifier] as? String else {
                fatalError("bundleIdentifier Key not set in plist for this environment")
            }
            return apiKey
        }()
    }
}
