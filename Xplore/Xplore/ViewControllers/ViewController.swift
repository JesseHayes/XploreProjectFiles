import MapKit
import UIKit
import Foundation





class ViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?



    @IBOutlet weak var mapView: MKMapView!


  
    
    

        // if screen loads ask for location permissions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        mapView.delegate = self;
        
        

         
        
        // Do any additional setup after loading the view.
    }


    //how to ask for location permissions
    private func configureLocationServices() {

        locationManager.delegate = self
        //check location permissions
        let status = CLLocationManager.authorizationStatus()
        //if location permissions not set, ask
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            //begin tracking location
            beginLocationUpdates(locationManager: locationManager)

        }
    }
    //begin tracking location
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        //show blue dot
        mapView.showsUserLocation = true
        //track location to best of phones ability
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //start updating location
        locationManager.startUpdatingLocation()

    }
    //zoom to location
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        //set zoom level
        let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        //tells map to zoom animated
        mapView.setRegion(zoomRegion, animated: true)
        
        
             
         
        let region = CLCircularRegion(center: coordinate, radius: 500, identifier: "geofence")
        
        locationManager.startMonitoring(for: region)
        
   
        
        
        
        
        
    }
    
    private func produceOverlay(with coordinate:CLLocationCoordinate2D) {
        
           
            
        let overlay = MKInvertedCircle(center: coordinate)
        let circle = MKCircle(center: coordinate, radius: 500)
        mapView.addOverlay(overlay)
        mapView.addOverlay(circle)
            
            if let renderer = mapView.renderer(for: circle) as? MKCircleRenderer {
            mapView.removeOverlays(mapView.overlays)
               renderer.fillColor = UIColor.red
               
            mapView.addOverlay(overlay)
            }
            
    
    
}
}

    



extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get Latest Location")

        guard let latestLocation = locations.first else {return }

        if currentCoordinate == nil{
            zoomToLatestLocation(with: latestLocation.coordinate)
            produceOverlay(with: latestLocation.coordinate)
        }

        currentCoordinate = latestLocation.coordinate

    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            print("The Status Changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager:  manager)
        }
    }




}

extension ViewController : MKMapViewDelegate {

func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    
    if let circle = overlay as? MKCircle {
        return MKInvertedCircleOverlayRenderer(circle: circle)
    } else {
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

}

