import Foundation


struct WorldClockModel{
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var city: String = ""
    
    init(identifier: String){
        
        //init calendar
        let calendar = Calendar.current
        
        //get seconds to add
        let secondsToAdd = secondsToAdd(identifier: identifier)
        
        //get city name
        let cityName = getCityName(identifier: identifier)
        
        //init clock
        let fullHours = calendar.component(.hour, from: Date().addingTimeInterval(TimeInterval(secondsToAdd)))
        hours = fullHours <= 12 ? fullHours : fullHours-12
        minutes = calendar.component(.minute, from: Date().addingTimeInterval(TimeInterval(secondsToAdd)))
        seconds = calendar.component(.second, from: Date())
        city = String(cityName)
        
    }
    
    
    private func secondsToAdd(identifier: String) -> Int{
            //TODO error handling for wrong identifiers
            //get this and identifiers timezone
            let thisTimezone = TimeZone.current
            let cityTimezone = TimeZone(identifier: identifier)!
            
            //get seconds from GTM from this and identifiers timezone
            let thisSecondsFromGMT = thisTimezone.secondsFromGMT()
            let citySecondsFromGMT = cityTimezone.secondsFromGMT()
            
            //prints
            print(thisTimezone.secondsFromGMT())
            print(cityTimezone.secondsFromGMT())
        
            return citySecondsFromGMT-thisSecondsFromGMT
    }
    
    private func getCityName(identifier: String) -> String{
        String(identifier.split(separator: "/").last!)
    }
    
    

    
}
