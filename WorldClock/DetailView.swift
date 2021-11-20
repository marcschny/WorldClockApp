import Foundation
import SwiftUI

struct DetailView: View{
    
    var identifier: String
    @ObservedObject var viewModel: WorldClockViewModel
    
    
    var body: some View{
        GeometryReader{ geometry in
            body(for: geometry.size)
        }.padding()
            
    }
    
    
    @ViewBuilder
    func body(for size: CGSize) -> some View{
        //if portrait mode
        if(size.width < size.height){
            VStack(){
                ClockFace(size: size, worldClockModel: viewModel.getTime())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: min(size.width, size.height), height: min(size.width, size.height))
                
                Text(viewModel.getCityName()).font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: min(size.width, size.height), height: min(size.width, size.height), alignment: Alignment.center)
                
            }
        }else{
            HStack(){
                ClockFace(size: size, worldClockModel: viewModel.getTime())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: min(size.width, size.height), height: min(size.width, size.height))
                
                Text(viewModel.getCityName()).font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: min(size.width, size.height), height: min(size.width, size.height), alignment: Alignment.center)
                
            }
        }
        
    }
    
}


@available(iOS 15.0, *) //since .previewInterfaceOrientation only available in ios >= 15.0
struct ContentView_Previews_DetailView: PreviewProvider {
    static var previews: some View {
        Group{
            DetailView(identifier: "Europe/Berlin", viewModel: WorldClockViewModel(timezone: "Europe/Berlin"))
                .previewInterfaceOrientation(.landscapeLeft)
            DetailView(identifier: "Europe/Berlin", viewModel: WorldClockViewModel(timezone: "Europe/Berlin"))
                .previewInterfaceOrientation(.portrait)
        }
    }
}
