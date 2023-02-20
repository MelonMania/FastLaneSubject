//
//  APIService.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation
import Alamofire
import RxSwift

let baseURL = "https://f9c1a8f3-132d-451a-988f-47527dbda002.mock.pstmn.io/latest/ios2/product"

class APIService {
    // API 호출
    static func getRequest() -> Observable<ResponseModel> {
        print("api 호출")
        return Observable.create { emitter in
            AF.request(baseURL,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json"])
                .validate()
                .responseDecodable(of: ResponseModel.self) { response in
                    print("response : \(response)")
                    switch response.result {
                    case .success(let data) :
                        print("데이터 : \(data)")
                        emitter.onNext(data)
                        emitter.onCompleted()
                    case .failure(let error) :
                        print("실패 : \(error)")
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
