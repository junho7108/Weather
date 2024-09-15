//
//  NetworkService+Rx.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Alamofire
import RxSwift

extension Reactive where Base: NetworkService {
    
    func sendGet<T: Decodable>(with url: String, parameters: Parameters? = nil) -> Observable<T?> {
        return Observable.create { [weak base] emitter in
            base?.sendGet(with: url, parameters: parameters) { (result: Result<T, Error>) in
                switch result {
                case .success(let model):
                    emitter.onNext(model)
                    
                case .failure(_):
                    emitter.onNext(nil)
                }
                emitter.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
