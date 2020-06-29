//
//  RemoteConfigValues.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Firebase

enum ValueKey: String {
    case splash
    case api_key
}

class RemoteConfigValues {
    static let shared = RemoteConfigValues()
    var loadingDoneCallback: (() -> Void)?
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.splash.rawValue : ""
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func fetchCloudValues() {
        let fetchDuration: TimeInterval = 0
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) {[weak self] status, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                return
            }
            RemoteConfig.remoteConfig().activate(completion: nil)
            self?.loadingDoneCallback?()
            print("Retrieved values from the cloud!")
        }
    }
    
    func getString(forKey key: ValueKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
}
