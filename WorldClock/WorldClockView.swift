import SwiftUI

//TODO: replace hard coded values
struct WorldClockView: View{
    
    @ObservedObject var viewModel: WorldClockViewModel
    
    var body: some View{
        GeometryReader{ geometry in
            body(for: geometry.size)
        }.padding()
            
    }
    
    //actual clock face builder
    @ViewBuilder
    func body(for size: CGSize) -> some View{
        ClockFace(size: size, worldClockModel: viewModel.getTime())
            .aspectRatio(contentMode: .fit)
            .frame(width: min(size.width, size.height), height: min(size.width, size.height))
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView(viewModel: WorldClockViewModel())
    }
}
