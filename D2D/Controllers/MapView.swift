import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.49413, longitude: 13.44651), span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006))
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
