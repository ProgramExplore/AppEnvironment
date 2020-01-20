//
//  AppConfiguration.swift
//
//  Created by Evan Xie on 2020/1/19.
//

import HandyJSON

struct AppConfiguration {
    
    fileprivate static let shared = AppConfiguration()
    
    /// The `key` in the `Info.plist` which tells the filename of the configuration plist file.
    fileprivate let keyInInfoPlist = "ConfigurationPlistFileName"
    
    fileprivate var values: Values!
    fileprivate var configurationType: ConfigurationType!
    
    private init() {
        let configInfo = loadConfigurationValues()
        self.values = configInfo.0
        self.configurationType = configInfo.1
    }
    
    fileprivate func loadConfigurationValues() -> (Values, ConfigurationType) {
        guard let filename = Bundle.main.infoDictionary?[keyInInfoPlist] as? String else {
            fatalError("Please specify configuration plist filename in Info.plist")
        }
        
        guard let type = ConfigurationType(rawValue: filename) else {
            fatalError("Not supported configuration name")
        }
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "plist") else {
            fatalError("Configuration plist file not found")
        }
        
        guard let dic = NSDictionary(contentsOf: url) else {
            fatalError("The format of configuration plist file is invalid")
        }
        
        guard let values = Values.deserialize(from: dic) else {
            fatalError("The format of configuration plist file is invalid")
        }
        return (values, type)
    }
    
}

// MARK: - Public APIs

extension AppConfiguration {
    
    enum ConfigurationType: String {
        case development = "Development"
        case staging = "Staging"
        case production = "Production"
    }
    
    struct OpenPlatform: HandyJSON {
        var name: String = ""
        var appId: String = ""
        var appSecret: String = ""
    }
    
    /// All the configuration values
    struct Values: HandyJSON {
        var serverURL: String = ""
        var bugly: OpenPlatform = OpenPlatform()
    }
    
    /// Type of app configuration which is applied.
    static var type: ConfigurationType {
        return shared.configurationType
    }
    
    /// Accessing all the configuration items by this property.
    static var values: Values {
        return shared.values
    }
}
