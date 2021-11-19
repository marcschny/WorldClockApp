import SwiftUI

//TODO: replace hard coded values
struct WorldClockView: View{
    
    var cities: Array<String> = [
        "Europe/Berlin",
        "Europe/London",
        "Australia/Brisbane",
        "Australia/Darwin",
        "Asia/Seoul",
        "America/Dominica",
        "Indian/Maldives",
        "Indian/Mahe",
        "Asia/Beirut",
        "Africa/Nairobi",
        "America/Havana",
        "Antarctica/South_Pole"
    ]
    
    
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
                    ForEach(cities, id: \.self){ city in
                        ClockRow(viewModel: WorldClockViewModel(timezone: city))
                        Divider()
                    }
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
