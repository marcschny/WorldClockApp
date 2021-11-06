import SwiftUI

struct Pointer: View{
    
    let type: PointerType
    let hour: Int
    let minute: Int
    let second: Int
    
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
                case .hour: return 6
                case .minute: return 4.5
                case .second: return 1.5
            }
        }
        
        //associated pointer length
        var length: CGFloat{
            switch self{
                case .hour: return 0.6
                case .minute: return 0.9
                case .second: return 0.95
            }
        }
        
        //associated pointer angle
        func angle(hour: Int, minute: Int, second: Int) -> Angle{
            switch self{
                case .hour: return Angle(degrees: (Double(hour) + Double(minute/60)) * timeMultiplier(type: .hour))
                case .minute: return Angle(degrees: Double(minute) * timeMultiplier(type: .minute))
                case .second: return Angle(degrees: Double(second) * timeMultiplier(type: .second))
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
            Path{ p in
                let center = CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                print("size: "+geo.size.width.description+", "+geo.size.height.description)
                p.move(to: center)
                p.addLine(to: CGPoint(x: center.x, y: center.y - self.type.length*geo.size.width ))
            }
            .stroke(style: StrokeStyle(lineWidth: self.type.width, lineCap: .round))
            .fill(self.type.color)
            .rotationEffect(self.type.angle(hour: self.hour, minute: self.minute, second: self.second))
        }
    }
    
    
}


//clockface midpoint
struct MidPoint: Shape{
    
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path{
        let center = CGPoint(x: rect.midX-(radius/2), y: rect.midY-(radius/2))
        
        return Path{ p in
            p.move(to: center)
            p.addEllipse(in: CGRect(origin: center, size: CGSize(width: radius, height: radius)))
        }
    }
}
