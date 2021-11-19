import SwiftUI

//TODO: replace hard coded values
struct WorldClockView: View{
    
    
    var body: some View{
        GeometryReader{ geometry in
            body(for: geometry.size)
        }.padding()
            
    }
    
    //actual clock face builder
    @ViewBuilder
    func body(for size: CGSize) -> some View{
        VStack{
            Spacer()
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ClockRow(viewModel: WorldClockViewModel(timezone: "Europe/Berlin"))
                    Divider()
                    ClockRow(viewModel: WorldClockViewModel(timezone: "Europe/London"))
                    Divider()
                    ClockRow(viewModel: WorldClockViewModel(timezone: "Australia/Brisbane"))
                    Divider()
                    ClockRow(viewModel: WorldClockViewModel(timezone: "Australia/Darwin"))
                    Divider()
                    ClockRow(viewModel: WorldClockViewModel(timezone: "Asia/Seoul"))
                }
            }
        }
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
