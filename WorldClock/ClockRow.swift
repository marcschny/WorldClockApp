import Foundation
import SwiftUI

struct ClockRow: View{
    
    @ObservedObject var viewModel: WorldClockViewModel
    
    var body: some View{
        HStack{
            Text(viewModel.getTime().city).font(.title)
            Spacer()
            ClockFace(size: CGSize(width: CGFloat(120), height: CGFloat(120)), worldClockModel: viewModel.getTime())
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
        }.padding()
    }
    
}

struct ContentView_Previews_ClockRow: PreviewProvider {
    static var previews: some View {
        ClockRow(viewModel: WorldClockViewModel(timezone: "Europe/Berlin"))
    }
}
