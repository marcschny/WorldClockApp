import SwiftUI

//TODO: replace hard coded values
struct WorldClockView: View{
    
    var body: some View{
        VStack{
            ClockFaceView()
        }.padding()
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
            
            //pointers (h,m,s)
            Pointer(type: .hour, hour: 5, minute: 10, second: 32) //hours
            Pointer(type: .minute, hour: 5, minute: 10, second: 32) //minutes
            Pointer(type: .second, hour: 5, minute: 10, second: 32) //seconds
            
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
