import Foundation
import SwiftUI

struct ClockRow: View{
    
    @ObservedObject var viewModel: WorldClockViewModel
    var height: CGFloat
    
    var body: some View{
        NavigationLink(
            destination: DetailView(
                identifier: viewModel.getTime().identifier!,
                viewModel: WorldClockViewModel(timezone: viewModel.getTime().identifier!))
        ){
            HStack{
                //highlight invalid identifiers
                if(viewModel.getCityName() == invalidIdentifier){
                    Text(viewModel.getCityName()).font(.title)
                        .italic()
                        .foregroundColor(.red)
                }else{
                    Text(viewModel.getCityName()).font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                ClockFace(
                    size: CGSize(
                        width: height*tileHeightMulitplier,
                        height: height*tileHeightMulitplier),
                        worldClockModel: viewModel.getTime()
                    )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: height*tileHeightMulitplier, height: height*tileHeightMulitplier)
            }
            .padding()
            
        }
    }
    
    // MARK: - Clock Row Constants
    private let tileHeightMulitplier = CGFloat(0.15)
    private let invalidIdentifier = "Invalid Identifier"
    
}

struct ContentView_Previews_ClockRow: PreviewProvider {
    static var previews: some View {
        ClockRow(viewModel: WorldClockViewModel(timezone: "Europe/Berlin"), height: 120)
    }
}
