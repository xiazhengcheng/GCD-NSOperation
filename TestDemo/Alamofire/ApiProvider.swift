//
//  ApiProvider.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/20.
//  Copyright © 2023 etlfab. All rights reserved.
//

import Moya
import Kingfisher
import HandyJSON
import SwiftyJSON

let NetWorkProvider = MoyaProvider<NetWorkApi>()

enum NetWorkApi {
    case upGradeVersion
}

extension NetWorkApi: TargetType {
    var headers: [String : String]? {
        return  nil
    }
    
    var path: String {
        switch self {
        case .upGradeVersion :
            return "user/api/v1/open/version-config/iOS"
        }
    }
    var method: Moya.Method{return .get}
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    var baseURL: URL {return URL(string: "https://www.finture.id/")!}
    
    var task: Task {
        let params: [String: Any] = [:]
        switch self {
        case .upGradeVersion: break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}

//MARK: 请求结果模型解析
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

//MARK: 统一请求封装
extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
        
            print("--------\(JSON(result.value?.data).description)")
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(UpGradeData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData as! T)
        })
    }
}
