//
//  Settings.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 27/5/24.
//

import Foundation

enum KeysUserDefaults{
    static let settingGame = "settingGame"
}
struct SettingsGame:Codable{
    var timerState: Bool
    var timeForGame: Int
}


class Settings{
    static var shared =  Settings()
    private let defaultSettings = SettingsGame(timerState: true, timeForGame: 30)
    var currentSettings : SettingsGame{
        get{
            if let data =  UserDefaults.standard.object(forKey: KeysUserDefaults.settingGame) as? Data{
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            }else{
                do{
                    let data = try  PropertyListEncoder().encode(defaultSettings)
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingGame)
                }catch{
                    print("error in SettingsGame get -",error)
                }
                return defaultSettings
            }
                
        }
        set{
            do{
                let data = try  PropertyListEncoder().encode(newValue)
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingGame)
            }catch{
                print("error in SettingsGame set -",error)
            }
        }
    }
    func resetSettings(){
        currentSettings = defaultSettings
    }
}
