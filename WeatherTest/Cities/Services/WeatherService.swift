// swiftlint:disable force_unwrapping

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let cityProvider = MoyaProvider<OpenWeathermap>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum OpenWeathermap {
    case severalCities(String)
}

extension OpenWeathermap: TargetType {
    public var sampleData: Data {
        switch self {
        case .severalCities( _):
            return "{\"cnt\":3,\"list\":[{\"coord\":{\"lon\":37.62,\"lat\":55.75},\"sys\":{\"type\":1,\"id\":7323,\"message\":0.0036,\"country\":\"RU\",\"sunrise\":1485753940,\"sunset\":1485784855},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"main\":{\"temp\":-10.5,\"pressure\":1028,\"humidity\":66,\"temp_min\":-11,\"temp_max\":-10},\"visibility\":10000,\"wind\":{\"speed\":5,\"deg\":200},\"clouds\":{\"all\":0},\"dt\":1485793175,\"id\":524901,\"name\":\"Moscow\"},{\"coord\":{\"lon\":30.52,\"lat\":50.45},\"sys\":{\"type\":1,\"id\":7358,\"message\":0.0268,\"country\":\"UA\",\"sunrise\":1485754480,\"sunset\":1485787716},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"main\":{\"temp\":-11.04,\"pressure\":1033,\"humidity\":61,\"temp_min\":-15,\"temp_max\":-9},\"visibility\":10000,\"wind\":{\"speed\":3,\"deg\":150},\"clouds\":{\"all\":0},\"dt\":1485793175,\"id\":703448,\"name\":\"Kiev\"},{\"coord\":{\"lon\":-0.13,\"lat\":51.51},\"sys\":{\"type\":1,\"id\":5091,\"message\":0.0034,\"country\":\"GB\",\"sunrise\":1485762036,\"sunset\":1485794875},\"weather\":[{\"id\":701,\"main\":\"Mist\",\"description\":\"mist\",\"icon\":\"50d\"},{\"id\":300,\"main\":\"Drizzle\",\"description\":\"light intensity drizzle\",\"icon\":\"09d\"}],\"main\":{\"temp\":7,\"pressure\":1012,\"humidity\":81,\"temp_min\":5,\"temp_max\":8},\"visibility\":10000,\"wind\":{\"speed\":4.6,\"deg\":90},\"clouds\":{\"all\":90},\"dt\":1485793175,\"id\":2643743,\"name\":\"London\"}]}".data(using: String.Encoding.utf8)!
        }
    }
    
   
    public var baseURL: URL {
        return URL(string: "http://samples.openweathermap.org/data/2.5/")! }
    private var appid: String {
        return "3c248307754e7116ddcad80d69c08910"
    }
    public var path: String {
        switch self {
        case .severalCities(_):
            return "group"
       
    }
    
}
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .severalCities(let ids):
            return .requestParameters(parameters: ["units": "metric", "appid":appid, "id":ids], encoding: URLEncoding.default)
//        default:
//            return .requestPlain
        }
    }
    public var validationType: ValidationType {
        switch self {
        case .severalCities:
            return .successCodes
//        default:
//            return .none
        }
    }
   
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

