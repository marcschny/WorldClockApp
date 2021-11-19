import SwiftUI


struct Pointer: View{
    
    let type: PointerType
    let worldClockModel: WorldClockModel
    let minSize: CGFloat
    
    //enumeration for different pointer types
    enum PointerType{
        case hour, minute, second
        
        //associated color
        var color: Color{
            switch self{
                case .hour: return .black
                case .minute: return .black
                case .second: return .orange
            }
        }
        
        //associated pointer width
        var width: CGFloat{
            switch self{
                case .hour: return 9
                case .minute: return 6.5
            case .second: return 2.5
            }
        }
        
        //associated (relative) pointer length
        var length: CGFloat{
            switch self{
                case .hour: return 0.55
                case .minute: return 0.8
                case .second: return 0.85
            }
        }
        
        //associated pointer angle
        func angle(worldClockModel: WorldClockModel) -> Angle{
            switch self{
            case .hour: return Angle(degrees: (Double(worldClockModel.hours) + Double(worldClockModel.minutes)/60) * timeMultiplier(type: .hour))
            case .minute: return Angle(degrees: Double(worldClockModel.minutes) * timeMultiplier(type: .minute))
            case .second: return Angle(degrees: Double(worldClockModel.seconds) * timeMultiplier(type: .second))
            }
        }
        
        //time multiplier to calculate angle
        func timeMultiplier(type: PointerType) -> Double{
            switch self{
            case .hour: return 360/12
            case .minute: return 360/60
            case .second: return 360/60
            }
        }
    
    }

    
    var body: some View{
        GeometryReader{ geo in
            // calc scaling factor, using 348 as suitable size
            let scaleFactor = minSize/348
            Path{ p in
                let center = CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                p.move(to: center)
                p.addLine(to: CGPoint(x: center.x, y: center.y - self.type.length*minSize/2 ))
            }
            .stroke(style: StrokeStyle(lineWidth: self.type.width*scaleFactor, lineCap: .round))
            .fill(self.type.color)
            .rotationEffect(self.type.angle(worldClockModel: worldClockModel))
        }
    }
    
    
}

struct ContentView_Previews_Pointer: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}



