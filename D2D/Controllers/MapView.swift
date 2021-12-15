import MapKit
import SwiftUI


struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkifLocationServiceIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView()
}
}
