import Foundation
import SwiftUI


struct ClockFace: View{
    
    let size: CGSize
    var worldClockModel: WorldClockModel
    
    var body: some View{
        return ZStack{
            //create one tick for each second
            ForEach(0..<60){
                tick in
                self.tick(at: tick)
            }
             
            //pointers (h,m,s)
            Pointer(type: .second, worldClockModel: worldClockModel, minSize: min(size.width, size.height)) //seconds
            Pointer(type: .minute, worldClockModel: worldClockModel, minSize: min(size.width, size.height)) //minutes
            Pointer(type: .hour, worldClockModel: worldClockModel, minSize: min(size.width, size.height)) //hours
            
            //clockface midpoint
            MidPoint(radius: defaultMidPointRadius, minSize: min(size.width, size.height))
                .fill(defaultMidPointColor)
            
        }
    }
    
    //function to create tick marks
    func tick(at tick: Int) -> some View{
        
        // calc scaling factor, using 348 as suitable size
        let scaleFactor = min(size.width, size.height)/348
        
        return VStack{
            Rectangle()
                .fill(tick % 5 == 0 ? thickTickColor : thinTickColor)
                .frame(
                    width: tick % 15 == 0 ? thickTickWidth : thinTickWidth,
                    height: tick % 15 == 0 ? thickTickLength : tick % 5 == 0 ? mediumTickLength : thinTickLength)
                .transformEffect(CGAffineTransform(a: scaleFactor, b: 0.0, c: 0.0, d: scaleFactor, tx: 0, ty: 0))
            Spacer()
        }
        .rotationEffect(.degrees(Double(tick)/60 * 360)) //rotate tick
    }
    
    //MARK: - Clock Face Constants
    private let defaultMidPointRadius = CGFloat(14)
    private let defaultMidPointColor = Color.orange
    
    private let thickTickColor = Color.black
    private let thickTickWidth = CGFloat(4.2)
    private let thickTickLength = CGFloat(17)
    
    private let thinTickColor = Color.gray
    private let thinTickWidth = CGFloat(3)
    private let thinTickLength = CGFloat(10)
    
    private let mediumTickLength = CGFloat(14)
    
    
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


struct ContentView_Previews_ClockFace: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
