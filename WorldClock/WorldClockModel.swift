import Foundation


struct WorldClockModel{
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var identifier: String? = ""
    
    
    //if an invalid identifier has been passed:
    //  - set identifier to "Invalid Identifier"
    //  - set time to 00:00:00
    init(identifier: String){
        
        //init calendar
        let calendar = Calendar.current
        
        //get seconds-to-add
        let secondsToAdd = secondsToAdd(identifier: identifier)
        
        //init clock (if secondsToAdd is -1, set clock to 00:00:00)
        let fullHours = secondsToAdd != -1 ? calendar.component(.hour, from: Date().addingTimeInterval(TimeInterval(secondsToAdd))) : 0
        self.hours = fullHours <= 12 ? fullHours : fullHours-12
        self.minutes = secondsToAdd != -1 ? calendar.component(.minute, from: Date().addingTimeInterval(TimeInterval(secondsToAdd))) : 0
        self.seconds = secondsToAdd != -1 ? calendar.component(.second, from: Date()) : 0
        self.identifier = secondsToAdd != -1 ? identifier : "Invalid Identifier"
        
    }
    
    //returns -1 if an invalid identifier has been passed
    private mutating func secondsToAdd(identifier: String) -> Int{
        
            //get this and identifiers timezone
            let thisTimezone = TimeZone.current
            let cityTimezone = TimeZone(identifier: identifier)
        
            if(cityTimezone==nil){
                //debugPrint("Wrong Identifier")
                return -1
            }else{
                //get seconds from GTM from this and identifiers timezone
                let thisSecondsFromGMT = thisTimezone.secondsFromGMT()
                let citySecondsFromGMT = cityTimezone?.secondsFromGMT()
                
                return citySecondsFromGMT!-thisSecondsFromGMT
            }
    
    }
    
    

    
}
