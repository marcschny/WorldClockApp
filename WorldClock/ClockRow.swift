import Foundation
import SwiftUI

struct ClockRow: View{
    
    @ObservedObject var viewModel: WorldClockViewModel
    
    var body: some View{
        NavigationLink(
            destination: DetailView(
                identifier: viewModel.getTime().identifier!,
                viewModel: WorldClockViewModel(timezone: viewModel.getTime().identifier!))
        ){
            HStack{
                //highlight invalid identifiers
                if(viewModel.getCityName() == "Invalid Identifier"){
                    Text(viewModel.getCityName()).font(.title)
                        .italic()
                        .foregroundColor(.red)
                }else{
                    Text(viewModel.getCityName()).font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                ClockFace(size: CGSize(width: CGFloat(120), height: CGFloat(120)), worldClockModel: viewModel.getTime())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
            }
            .padding()
            
        }
    }
    
}

struct ContentView_Previews_ClockRow: PreviewProvider {
    static var previews: some View {
        ClockRow(viewModel: WorldClockViewModel(timezone: "Europe/Berlin"))
    }
}
