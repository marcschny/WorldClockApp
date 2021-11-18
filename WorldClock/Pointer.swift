import SwiftUI


//TODO: Clean up Shapes and Views:
//TODO: - create struct for each Shape
//TODO: - change relative pointer lengths to absolute ones (like in pointer widths)
struct Pointer: View{
    
    let type: PointerType
    let worldClockModel: WorldClockModel
    let size: CGSize
    
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
        
        //associated (absolute) pointer width
        var width: CGFloat{
            switch self{
                case .hour: return 8.2
                case .minute: return 6
                case .second: return 2
            }
        }
        
        //associated (relative) pointer length
        var length: CGFloat{
            switch self{
                case .hour: return 0.6
                case .minute: return 0.9
                case .second: return 0.95
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
            let scaleFactor = min(size.width, size.height)/348
            Path{ p in
                let center = CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                print("size: \(size.width), \(size.height)")
                print("center: \(center)")
                //print("size: "+geo.size.width.description+", "+geo.size.height.description)
                p.move(to: center)
                p.addLine(to: CGPoint(x: center.x, y: center.y - self.type.length*geo.size.width ))
            }
            .stroke(style: StrokeStyle(lineWidth: self.type.width*scaleFactor, lineCap: .round))
            .fill(self.type.color)
            .rotationEffect(self.type.angle(worldClockModel: worldClockModel))
        }
        
    }
    
    
}


//clockface midpoint
struct MidPoint: Shape{
    
    var radius: CGFloat
    var minSize: CGFloat
    
    func path(in rect: CGRect) -> Path{
        // calc scaling factor, using 348 as suitable size
        let scaleFactor = minSize/348
        // calc center of rect
        let center = CGPoint(x: (rect.midX/scaleFactor-(radius/2)), y: (rect.midY/scaleFactor-(radius/2)))
        
        return Path{ p in
            p.move(to: center)
            p.addEllipse(in: CGRect(origin: center, size: CGSize(width: radius, height: radius)))
        }
        .applying(CGAffineTransform(a: scaleFactor, b: 0.0, c: 0.0, d: scaleFactor, tx: 0, ty: 0))
    }
}
