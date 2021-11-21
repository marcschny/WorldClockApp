import SwiftUI


struct WorldClockView: View{
    
    //MARK: - List of cities
    let cities: Array<String> = [
        "Europe/Berlin","Europe/London",
        "Australia/Brisbane",
        "Australia/Darwin",
        "Asia/Seoul",
        "America/Dominica",
        "Indian/Maldives",
        "Indian/Mahe",
        "Asia/Beirut",
        "Africa/Nairobi",
        "America/Havana",
        "Europe/Bernn", //invalid identifier
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
        NavigationView{
            VStack{
                Spacer()
                Text("World Clock")
                    .font(.system(size: 44, design: .rounded))
                    .foregroundColor(.orange)
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ForEach(cities, id: \.self){ city in
                            ClockRow(
                                viewModel: WorldClockViewModel(timezone: city),
                                height: max(size.width, size.height)
                            )
                            if city != cities.last { Divider() }
                        }
                    }
                }
            }
            .navigationBarTitle("World Clock")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
