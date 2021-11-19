import Foundation
import UIKit

class WorldClockViewModel: ObservableObject{
    
    @Published private var model: WorldClockModel
    private var timezone: String
    
    init(timezone: String){
        model = WorldClockViewModel.loadTime(timezone: timezone)
        self.timezone = timezone
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    //runs each second
    @objc func fireTimer(){
        model = WorldClockViewModel.loadTime(timezone: timezone)
    }
    
    static func loadTime(timezone: String) -> WorldClockModel{
        return WorldClockModel(identifier: timezone)
    }
    
    func getTime() -> WorldClockModel{
        return model
    }
    
    
    
}
