//
//  CoreDataManager.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentConditions: [CurrentCondition] = []
    var lastUpdated: Date? = nil
    
    private override init() {
        super.init()
        getAllCurrentCondition()
    }
    
    func getAllCurrentCondition() {
        do {
            currentConditions = try context.fetch(CurrentCondition.fetchRequest())
            
            if lastUpdated == nil || Date().timeIntervalSince(lastUpdated!) >= 1800 {
                lastUpdated = Date()
                let cityIDs = currentConditions.map {$0.cityId!}
                WeatherAPIManager.shared.fetchBulkWeatherData(cityIDs: cityIDs) { bulkCurrentWeatherResponse in
                    self.updateBulkCurrentCondition(response: bulkCurrentWeatherResponse)
                }
                currentConditions = try context.fetch(CurrentCondition.fetchRequest())
            }
            
        }
        catch {
            print(error)
        }
    }
    
    func createCurrentCondition(_ response: CurrentWeatherResponse) {
        let newCC = CurrentCondition(context: context)
        newCC.cityId = String(response.id)
        newCC.desc = response.weather[0].description
        newCC.hi_temp = response.main.temp_max
        newCC.humidity = Int64(response.main.humidity)
        newCC.icon = response.weather[0].icon
        newCC.lat = response.coord.lat
        newCC.lon = response.coord.lon
        newCC.lo_temp = response.main.temp_min
        newCC.name = response.name + ", " + response.sys.country
        newCC.temp = response.main.temp
        newCC.wind_speed = response.wind.speed
        saveContext()
        getAllCurrentCondition()
    }
    
    func deleteCurrentCondition(_ currentCondition: CurrentCondition) {
        context.delete(currentCondition)
        saveContext()
        getAllCurrentCondition()
    }
    
    func updateCurrentCondition(response: CurrentWeatherResponse)  {
        let fetchRequest = CurrentCondition.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityId = %@", String(response.id))
        var fetchResult: [CurrentCondition] = []
        do {
            fetchResult = try context.fetch(fetchRequest)
        }
        catch {
            print(error)
        }
        
        for cc in fetchResult {
            cc.desc = response.weather[0].description
            cc.hi_temp = response.main.temp_max
            cc.humidity = Int64(response.main.humidity)
            cc.icon = response.weather[0].icon
            cc.lat = response.coord.lat
            cc.lon = response.coord.lon
            cc.lo_temp = response.main.temp_min
            cc.name = response.name + ", " + response.sys.country
            cc.temp = response.main.temp
            cc.wind_speed = response.wind.speed
        }
        
        saveContext()
        getAllCurrentCondition()
    }
    
    func updateBulkCurrentCondition(response: BulkCurrentWeatherResponse)  {
        for currentWeatherResponseOld in response.list {
            let fetchRequest = CurrentCondition.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "cityId = %@", String(currentWeatherResponseOld.id))
            var fetchResult: [CurrentCondition] = []
            do {
                fetchResult = try context.fetch(fetchRequest)
            }
            catch {
                print(error)
            }
            
            for cc in fetchResult {
                cc.desc = currentWeatherResponseOld.weather[0].description
                cc.hi_temp = currentWeatherResponseOld.main.temp_max
                cc.humidity = Int64(currentWeatherResponseOld.main.humidity)
                cc.icon = currentWeatherResponseOld.weather[0].icon
                cc.lat = currentWeatherResponseOld.coord.lat
                cc.lon = currentWeatherResponseOld.coord.lon
                cc.lo_temp = currentWeatherResponseOld.main.temp_min
                cc.name = currentWeatherResponseOld.name + ", " + currentWeatherResponseOld.sys.country
                cc.temp = currentWeatherResponseOld.main.temp
                cc.wind_speed = currentWeatherResponseOld.wind.speed
            }
        }
        
        saveContext()
        getAllCurrentCondition()
    }
    
    private func saveContext() {
        do {
            try context.save()
            getAllCurrentCondition()
        }
        catch {
            print(error)
        }
    }
}
