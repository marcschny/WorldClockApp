import Foundation


struct WorldClockModel{
    
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    init(){
        let fullHours = Calendar.current.component(.hour, from: Date())
        hours = fullHours <= 12 ? fullHours : fullHours-12
        minutes = Calendar.current.component(.minute, from: Date())
        seconds = Calendar.current.component(.second, from: Date())
        //print(hours.description+":"+minutes.description+":"+seconds.description)
    }

    
}
