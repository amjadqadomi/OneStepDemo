//
//  NetworkUtils.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import Alamofire

class NetworkUtils {
    class func sendRequest<T:Decodable>(requestURL: String, method: HTTPMethod, encoding: ParameterEncoding = URLEncoding.default ,parameters: Parameters, headers: HTTPHeaders, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)->Void, networkIssue: @escaping (_ error: Error) -> Void) -> Void  {

        AF.request(requestURL, method: method, parameters: parameters, encoding: encoding,headers: headers)
            .responseDecodable { (dataResponse: DataResponse<T, AFError>) in
                let statusCode = dataResponse.response?.statusCode
                print(statusCode)
                completion(dataResponse.result)
            }
//
//        AF.request(requestURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
//            .responseString { (dataResponse) in
//                print(dataResponse)
//            }
        
      
    }
    
    class func getStepRateOnly(completion:@escaping (Result<WalkDetails,AFError>)->Void, networkIssue: @escaping (_ error: Error) -> Void) {
        NetworkUtils.sendRequest(requestURL: WebService.baseURL + WebService.stepRateOnlyURL, method: .get, parameters: [:], headers: [:], completion: completion, networkIssue: networkIssue)
    }
    
    class func getFullParameters(completion:@escaping (Result<WalkDetails,AFError>)->Void, networkIssue: @escaping (_ error: Error) -> Void) {
        NetworkUtils.sendRequest(requestURL: WebService.baseURL + WebService.allParametersURL, method: .get, parameters: [:], headers: [:], completion: completion, networkIssue: networkIssue)

    }
}
