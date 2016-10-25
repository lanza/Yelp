import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import OAuthSwift
import CoreLocation

class Yelper {
    private init() {
        auth()
    }
    static var shared = Yelper()
    
    let appID = "lypF1GRqx3l4xBfraTs-iA"
    let appSecret = "lvpWt8kVjIelMVkHr30hggZz80OxfO7eh93XzpHacAp071ZEYM0Bs4RBmxeHy67V"
    let authURL = "https://api.yelp.com/oauth2/token"
    
    func auth() {
        let parameters = ["grant_type":"client_credentials", "client_id":appID, "client_secret":appSecret]
        Alamofire.request(authURL, method: .post, parameters: parameters).responseJSON { response in
            guard let data = response.result.value else {
                return
            }
            let json = JSON(data)
            self.accessToken.value = json["access_token"].stringValue
        }
    }

    var accessToken = Variable("")
    let base = "https://api.yelp.com/v3/businesses/search"
    var headers: HTTPHeaders { return ["Authorization":"Bearer \(accessToken.value)"] }
    
    func get(parameters: [String:Any], offset: Int, location: CLLocation, completion: @escaping ([Business]?) -> ()) {
        accessToken.asObservable().subscribe(onNext: { accessToken in
            guard accessToken != "" else { return }
            var parameters = parameters
            parameters["latitude"] = String(location.coordinate.latitude)
            parameters["longitude"] = String(location.coordinate.longitude)
            parameters["offset"] = String(offset)
            Alamofire.request(self.base, parameters: parameters, headers: self.headers).responseJSON { resonse in
                guard let data = resonse.result.value else {
                    return completion(nil)
                }
                print(data)
                let businesses = Business.parse(data: data)
                completion(businesses)
            }
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}


