import Foundation
import UIKit

class WorldClockViewModel: ObservableObject{
    
    @Published private var model: WorldClockModel
    private var timezone: String
    
    init(timezone: String){
        model = WorldClockViewModel.loadTime(timezone: timezone)
        self.timezone = timezone
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common) //make seconds pointer keep going while scrolling
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
