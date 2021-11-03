import SwiftUI

//TODO: replace hard coded values
struct WorldClockView: View{
    
    var body: some View{
        VStack{
            ClockFaceView()
        }.padding()
    }
    
    
}

//pointer
struct Pointer: Shape{
    
    var width: CGFloat
    var height: CGFloat
    //TODO: pass color
    
    
    func path(in rect: CGRect) -> Path{
        Path{ p in
            print(rect.maxY)
            let center = CGPoint(x: rect.midX, y: rect.midY)
            
            p.move(to: center)
            p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY/2-height))
        }
        .strokedPath(StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round ))
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


//actual clock face
struct ClockFaceView: View{
    
    var body: some View{
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View{
        ZStack{
            //create one tick for each second
            ForEach(0..<60){
                tick in
                self.tick(at: tick)
            }
            //minutes pointer
            Pointer(width: 4.5, height: size.width/2-30)
                .fill(Color.black)
            //hour pointer
            Pointer(width: 6, height: size.width/2-58)
                .fill(Color.black)
                .rotationEffect(Angle.degrees(90))
            //seconds pointer
            Pointer(width: 1.5, height: size.width/2-26)
                .fill(Color.orange)
                .rotationEffect(Angle.degrees(120))
            //clockface midpoint
            MidPoint(radius: 12).fill(Color.orange)
            
            Color.clear
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: size.width, height: size.width)
    }
    
    //function to create tick marks
    func tick(at tick: Int) -> some View{
        VStack{
            Rectangle()
                .fill(tick % 5 == 0 ? Color.black : Color.gray)
                .opacity(1)
                .frame(width: tick % 15 == 0 ? 3 : 2, height: tick % 15 == 0 ? 17 : tick % 5 == 0 ? 14 : 10)
            Spacer()
        }
        .rotationEffect(.degrees(Double(tick)/60 * 360)) //rotate tick
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
