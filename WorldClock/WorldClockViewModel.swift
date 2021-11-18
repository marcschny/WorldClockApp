import Foundation
import UIKit

class WorldClockViewModel: ObservableObject{
    
    @Published private var model: WorldClockModel
    
    init(){
        model = WorldClockViewModel.loadTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    //runs each second
    @objc func fireTimer(){
        model = WorldClockViewModel.loadTime()
    }
    
    static func loadTime() -> WorldClockModel{
        return WorldClockModel()
    }
    
    func getTime() -> WorldClockModel{
        return model
    }
    
    
    
}
