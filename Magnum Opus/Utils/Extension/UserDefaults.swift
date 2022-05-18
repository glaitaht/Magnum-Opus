//
//  UserDefaults.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 30.04.2022.
//

import Foundation

extension UserDefaults{
    static func isOnboarded() -> Bool{
        let onboarded : Bool = UserDefaults.standard.object(forKey: "onboarded") as? Bool ?? false
        return onboarded
    }

    static func setOnboarded(){
        UserDefaults.standard.set(true, forKey: "onboarded")
        UserDefaults.standard.synchronize()
    }
    
    static func getFavouriteGamesFromUserDefault(forKey: String) -> [Int]? {
        let allFavouritesFromUserDefaults: [Int] = UserDefaults.standard.object(forKey: forKey) as? [Int] ?? []
        return allFavouritesFromUserDefaults
    }
    
    static func setFavouriteGameToUserDefault(forKey: String,add: Bool,ID: Int){
        var allFavs = getFavouriteGamesFromUserDefault(forKey: forKey)
        if add{
            allFavs?.append(ID)
        }
        else{
            allFavs = allFavs?.compactMap({ $0 == ID ? nil : $0 })
        }
        UserDefaults.standard.set(allFavs, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
}
