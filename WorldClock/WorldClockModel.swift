import Foundation


struct WorldClockModel{
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var city: String = ""
    
    
    //if an invalid identifier has been passed:
    //  - set city name to "Invalid Identifier"
    //  - set city time to 00:00:00
    init(identifier: String){
        
        //init calendar
        let calendar = Calendar.current
        
        //get seconds to add
        let secondsToAdd = secondsToAdd(identifier: identifier)
        
        //get city name (and replace underscores with spaces)
        let cityName = secondsToAdd != -1 ? getCityName(identifier: identifier).replacingOccurrences(of: "_", with: " ") : "Invalid Identifier"
        
        //init clock (if secondsToAdd is -1, set clock to 00:00:00)
        let fullHours = secondsToAdd != -1 ? calendar.component(.hour, from: Date().addingTimeInterval(TimeInterval(secondsToAdd))) : 0
        hours = fullHours <= 12 ? fullHours : fullHours-12
        minutes = secondsToAdd != -1 ? calendar.component(.minute, from: Date().addingTimeInterval(TimeInterval(secondsToAdd))) : 0
        seconds = secondsToAdd != -1 ? calendar.component(.second, from: Date()) : 0
        city = String(cityName)
        
    }
    
    //returns -1 if an invalid identifier has been passed
    private func secondsToAdd(identifier: String) -> Int{
        
            //get this and identifiers timezone
            let thisTimezone = TimeZone.current
            let cityTimezone = TimeZone(identifier: identifier)
        
            if(cityTimezone==nil){
                debugPrint("Wrong Identifier")
                return -1
            }else{
                //get seconds from GTM from this and identifiers timezone
                let thisSecondsFromGMT = thisTimezone.secondsFromGMT()
                let citySecondsFromGMT = cityTimezone?.secondsFromGMT()
                
                return citySecondsFromGMT!-thisSecondsFromGMT
            }
    
    
    }
    
    private func getCityName(identifier: String) -> String{
        String(identifier.split(separator: "/").last!)
    }
    
    

    
}
