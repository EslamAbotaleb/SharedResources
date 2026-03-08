//
//  AccessManagementManager.swift
//  CERQEL
//
//  Created by ahmed maher on 16/12/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation

class AccessManagementManager {
    
    private static var _shared: AccessManagementManager?
    private var permittedFeatures: [Module]?
    private var localData: LocalData = LocalDataImpl()
    
    // Method to reset the singleton instance
    static func resetSingleton() {
        _shared = nil
        
    }
    
    static var shared: AccessManagementManager {
        get {
            if _shared == nil {
                _shared = AccessManagementManager()
            }
            return _shared!
        }
    }
    
    var isUserhavePermission: Bool {
        let permission = getPermittdModulesWithOnlyIdentifiers()
        return permission.count > 5
    }
    
    
    func setPermittedModules() {
        mapPermittedFeatures()
    }
    
    
    func getPermittdModulesWithOnlyIdentifiers() -> [FeaturesIdentifiers] {
        var permittedFeatures = self.getPermittedFeatures()
        permittedFeatures.append(.AllTabsGlobalSearch)
        permittedFeatures.append(.HomeScreen)
        permittedFeatures.append(.MoreScreen)
        permittedFeatures.append(.EmployeeGlobalSearch)
        permittedFeatures.append(.CompanyProfile)
        return permittedFeatures
    }
    
    
    
    func reset() -> [TenantListEntity]{
        return localData.get(object: [TenantListEntity].self, key: .tenantList) ?? []
    }
    
    private func mapPermittedFeatures () {
        self.permittedFeatures = mapFeaturesToModules(getPermittedFeatures())
    }
    
    private func mapFeaturesToModules(_ permittedFeatures: [FeaturesIdentifiers]) -> [Module] {
        var modulesMap: [ModulesIdentifiers: [FeaturesIdentifiers]] = [:]
        
        // Reverse map each feature to its module
        for feature in permittedFeatures {
            if let module = ModuleFeatureMapping.featureToModule[feature] {
                modulesMap[module, default: []].append(feature)
            }
        }
        
        // Build final modules array
        var modules: [Module] = []
        
        for (moduleKey, features) in modulesMap {
            let allModuleFeatures = ModuleFeatureMapping.hierarchy[moduleKey] ?? []
            let isFullAccess = Set(features) == Set(allModuleFeatures)
            
            let featureModules = features.map { feature in
                Module(
                    key: feature.rawValue,
                    fullAccess: nil,
                    name: nil,
                    features: nil,
                    permitted: true
                )
            }
            
            let module = Module(
                key: moduleKey.rawValue,
                fullAccess: isFullAccess,
                name: nil,
                features: featureModules,
                permitted: nil
            )
            
            modules.append(module)
        }
        
        return modules
    }
    
    
    private func getPermittedFeatures() -> [FeaturesIdentifiers] {
        guard let payload: [String: Any] = AuthManager.shared.modules else {return []}
        let result = extractModulesAndFeatures(from: payload)
        var permittedFeatures = [FeaturesIdentifiers]()
        for (module, features) in result {
            print("Module: \(module.rawValue)")
            for feature in features {
                print("  - Feature: \(feature.rawValue)")
                permittedFeatures.append(feature)
            }
        }
        return permittedFeatures
    }
    
    func extractModulesAndFeatures(from payload: [String: Any]) -> [ModulesIdentifiers: [FeaturesIdentifiers]] {
        var result: [ModulesIdentifiers: [FeaturesIdentifiers]] = [:]
        
        for module in ModulesIdentifiers.allCases {
            let moduleKey = module.rawValue
            let moduleIsEnabled = payload[moduleKey] as? String == "F"
            guard let allFeatures = ModuleFeatureMapping.hierarchy[module] else { continue }
            
            if moduleIsEnabled {
                // Include all features of the module
                result[module] = allFeatures
            } else {
                // Include only explicitly listed features from this module
                let enabledFeatures = allFeatures.filter { feature in
                    if let value = payload[feature.rawValue] as? String {
                        return value.contains("F") || value.contains("PV") 
                    }else {
                        return false
                    }
                }
                if !enabledFeatures.isEmpty {
                    result[module] = enabledFeatures
                }
            }
        }
        
        return result
    }
    
}

enum FeaturesIdentifiers : String  {
    case AllTabsGlobalSearch = "Fe100";
    case HomeScreen = "Fe200";
    case MoreScreen = "Fe300";
    case EmployeeGlobalSearch = "Fe400";
    case CompanyProfile = "Fe500";
    
    
    // M1
    case Groups = "F10";
    case Roles = "F11";
    case Tenants = "F12";
    case Users = "F13";
    
    
    // M2
    case Calendar = "F20";
    case Prayer = "F21";
    case Weather = "F22";
    
    
    // M3
    case About = "F30";
    case Announcments = "F31";
    case Applications = "F32";
    case Banners = "F33";
    case Dashboard = "F34";
    case DocumentLibrary = "F35";
    case Events = "F36";
    case FAQs = "F37";
    case KnowledgeBase = "F38";
    case MediaLibrary = "F39";
    case News = "F40";
    case Offers = "F41";
    
    
    // M4
    case AllServices = "F50";
    case Inbox = "F51";
    case Services = "F52";
    
    
    // M5
    case Notifications = "F60";
    
    
    // M6
    case GroupView = "F70";
    case Themes = "F71";
    
    
    // M7
    case Surveys = "F80";
}

enum ModulesIdentifiers: String, CaseIterable {
    case AccessManagement = "M1"
    case Configurations = "M2"
    case ContentManagementSystem = "M3"
    case EServices = "M4"
    case Notifications = "M5"
    case Setting = "M6"
    case Surveys = "M7"
}

struct ModuleFeatureMapping {
    static let hierarchy: [ModulesIdentifiers: [FeaturesIdentifiers]] = [
        .AccessManagement: [.Groups, .Roles, .Tenants, .Users],
        .Configurations: [.Calendar, .Prayer, .Weather],
        .ContentManagementSystem: [.About, .Announcments, .Applications, .Banners, .Dashboard,
                                   .DocumentLibrary, .Events, .FAQs, .KnowledgeBase, .MediaLibrary,
                                   .News, .Offers],
        .EServices: [.AllServices, .Inbox, .Services],
        .Notifications: [.Notifications],
        .Setting: [.GroupView, .Themes],
        .Surveys: [.Surveys]
    ]
    
    static let featureToModule: [FeaturesIdentifiers: ModulesIdentifiers] = {
        var map: [FeaturesIdentifiers: ModulesIdentifiers] = [:]
        for (module, features) in hierarchy {
            for feature in features {
                map[feature] = module
            }
        }
        return map
    }()
}
