import Foundation
import UIKit

class WorldClockViewModel: ObservableObject{
    
    @Published private var model: WorldClockModel
    
    init(){
        model = WorldClockViewModel.createClock()
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    //runs each second
    @objc func fireTimer(){
        model = WorldClockModel.init()
        print("fired!")
    }
    
    static func createClock() -> WorldClockModel{
        return WorldClockModel()
    }
    
    func getTime()->WorldClockModel{
        return model
    }
    
    
    
}
