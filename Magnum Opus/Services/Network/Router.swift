//
//  Router.swift
//  ViperNews
//
//  Created by Egitim on 22.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let apiKey = "82175ae5b9707e1ed2c0087c7238e567"
    
    case genre
    case upcoming(page: Int?)
    case popular(page: Int?)
    case toprated(page: Int?)
    case sliderNowplaying
    case searchedMovie(name: String) //by name
    case movieDetail(movieID: Int)
    case movieDetailSimilar(movieID: Int)
    
    var baseURL: URL? {
        if let x = URL(string: "https://api.themoviedb.org/3/"){
            return x
        }
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .genre, .upcoming, .popular, .toprated, .sliderNowplaying, .searchedMovie
            , .movieDetail, .movieDetailSimilar:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        switch self {
        case .genre:
            return nil
        case .upcoming(page: let page):
            params["page"] = page
        case .popular(page: let page):
            params["page"] = page
        case .toprated(page: let page):
            params["page"] = page
        case .sliderNowplaying:
            return nil
        case .searchedMovie(name: let name):
            params["query"] = name
        case .movieDetail(movieID: _):
            return nil
        case .movieDetailSimilar(movieID: _):
            return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .genre:
            return "genre/movie/list"
        case .upcoming:
            return "movie/upcoming"
        case .popular:
            return "movie/popular"
        case .toprated:
            return "movie/top_rated"
        case .sliderNowplaying:
            return "movie/now_playing"
        case .searchedMovie:
            return "search/movie"
        case .movieDetail(movieID: let ID):
            return "movie/\(ID)"
        case .movieDetailSimilar(movieID: let ID):
            return "movie/\(ID)/similar"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        if let baseURL = self.baseURL  {
            var urlRequest = URLRequest(url: (baseURL.appendingPathComponent(path)))
            
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoding: ParameterEncoding = {
                switch method {
                case .get:
                    return URLEncoding.default
                default:
                    return JSONEncoding.default
                }
            }()
            
            var completeParameters = parameters ?? [:]
            
            completeParameters["api_key"] = Router.apiKey
            
            let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
            //debugPrint("************> MY URL: ", urlRequestPrint.url ?? "")
            
            return try encoding.encode(urlRequest, with: completeParameters)
        }

        return URLRequest(url: URL(string: "error")!)
    }
}
