//
//  APIService.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation
import Alamofire
import RxSwift

let baseURL = "https://b1804a28-20f2-4c1d-b643-a8456583a821.mock.pstmn.io/latest/ios/products"

class APIService {
    // API 호출
    static func getRequest() -> Observable<ResponseModel> {
        return Observable.create { emitter in
            AF.request(baseURL, method: .get, headers: nil)
                .validate()
                .responseDecodable(of: ResponseModel.self) { response in
                    switch response.result {
                    case .success(let data) :
                        print("시작")
                        print(data)
                        emitter.onNext(data)
                        emitter.onCompleted()
                    case .failure(let error) :
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
