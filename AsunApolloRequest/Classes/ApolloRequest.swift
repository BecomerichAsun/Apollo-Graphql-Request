import ApolloAlamofire
import Alamofire
import SwiftyJSON
import HandyJSON
import YYImage
import Apollo

public struct ApolloRequest {

    /// Apollod调用对象
    public var apollo: ApolloClient?

    /// 是否需要Loading样式
    public var hasLoading: Bool = false

    /// 回调线程
    public var queue: DispatchQueue = DispatchQueue.main

    /// Json
    public var jsonHeader: String = ""

    /// 缓存策略
    public var requestCache:CachePolicy = .fetchIgnoringCacheData

    let window = UIApplication.shared.keyWindow

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }

    /// 是否需要Loading样式
    ///
    /// - Parameter hidden: 是否需要
    mutating func updateHasLoading(hidden: Bool) {
        self.hasLoading = hidden
    }

    /// 回调线程
    ///
    /// - Parameter isMain: 是否为主线程
    mutating func updateQueue(isMain: DispatchQueue) {
        self.queue = isMain
    }

    /// 转模型头部解析
    ///
    /// - Parameter path: 模型头部字段名
    mutating func updateJsonHeader(path: String) {
        self.jsonHeader = path
    }

    /// 请求缓存
    ///
    /// - Parameter type: 缓存类型
    mutating func updateRequestCache(type: CachePolicy) {
        self.requestCache = type
    }

    public func fetchSingleModelRequest<Query: GraphQLQuery,T: HandyJSON>(   query: Query,
                                                                             type: T.Type,
                                                                             success successCallback: @escaping (T?) -> Void = {_ in },
                                                                             failure failureCallback: @escaping (Error) -> Void = {_ in }){
        if hasLoading  {
            UUHud.showHud(inView: window ?? UIWindow())
        }
        self.apollo?.fetch(query: query, cachePolicy: requestCache, queue: queue) { (result, error) in
            if self.hasLoading  {
                UUHud.hideHud(inView: self.window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {
                    let json = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollo Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successCallback(model)
                    }
                }
            }
        }
    }

    public func fetchSingleArrayRequest<Query: GraphQLQuery,T: HandyJSON>(   query: Query,
                                                                             type: T.Type,
                                                                             success successCallback: @escaping ([T?]) -> Void = {_ in }, failureCallback: @escaping (Error) -> Void = {_ in }){

        if hasLoading  {
            UUHud.showHud(inView: window ?? UIWindow())
        }
        self.apollo?.fetch(query: query, cachePolicy: requestCache, queue: queue) { (result, error) in
            if self.hasLoading  {
                UUHud.hideHud(inView: self.window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {
                    let json = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollo Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeModelArrayFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successCallback(model)
                    }
                }
            }
        }
    }


    public func performSingleRequest<Mutation: GraphQLMutation,T: HandyJSON>(
        _ mutation: Mutation,
        _ type: T.Type? = nil,
        success successCallback: @escaping (T?) -> Void = {_ in },
        failure failureCallback: @escaping (Error) -> Void = {_ in }){
        if hasLoading {
            UUHud.showHud(inView: window ?? UIWindow())
        }

        self.apollo?.perform(mutation: mutation, queue: queue) { (result, error) in
            if self.hasLoading {
                UUHud.hideHud(inView: self.window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {
                    let json = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollos Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successCallback(model)
                    }
                }
            }
        }
    }

    public func performSingleArrRequest<Mutation: GraphQLMutation,T: HandyJSON>(
        _ mutation: Mutation,
        _ type: T.Type? = nil,
        success successArrCallback: @escaping ([T?]) -> Void = {_ in },
        failure failureCallback: @escaping (Error) -> Void = {_ in }){
        if hasLoading {
            UUHud.showHud(inView: window ?? UIWindow())
        }

        self.apollo?.perform(mutation: mutation, queue: queue) { (result, error) in
            if self.hasLoading {
                UUHud.hideHud(inView: self.window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {
                    let json = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollos Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeModelArrayFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successArrCallback(model)
                    }
                }
            }
        }
    }

    /// 订阅
    public func subscribeSigleRequet<Subscription: GraphQLSubscription,T: HandyJSON>(
        _ subscription: Subscription,
        _ type: T.Type? = nil,
        success successCallback: @escaping (T?) -> Void = {_ in },
        failure failureCallback: @escaping (Error) -> Void = {_ in }){
        let window = UIApplication.shared.keyWindow
        if hasLoading  {
            UUHud.showHud(inView: window ?? UIWindow())
        }
        self.apollo?.subscribe(subscription: subscription) { (result, error) in
            if self.hasLoading  {
                UUHud.hideHud(inView: window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {

                    let json:String = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollos Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successCallback(model)
                    }
                }
            }
        }
    }

    /// 订阅
    public func subscribeSigleArrRequet<Subscription: GraphQLSubscription,T: HandyJSON>(
        _ subscription: Subscription,
        _ type: T.Type? = nil,
        success successCallback: @escaping ([T?]) -> Void = {_ in },
        failure failureCallback: @escaping (Error) -> Void = {_ in }){
        let window = UIApplication.shared.keyWindow
        if hasLoading  {
            UUHud.showHud(inView: window ?? UIWindow())
        }
        self.apollo?.subscribe(subscription: subscription) { (result, error) in
            if self.hasLoading  {
                UUHud.hideHud(inView: window ?? UIWindow())
            }
            if let er = error {
                failureCallback(er)
            } else {
                if let response = result?.data {

                    let json = JSON(response.jsonObject).rawString() ?? ""
                    if json.count == 0 {
                        print("Apollos Json ===\(json)")
                        return
                    } else {
                        guard let model = JSONDeserializer<T>.deserializeModelArrayFrom(json: json, designatedPath: self.jsonHeader) else {
                            return
                        }
                        successCallback(model)
                    }
                }
            }
        }
    }
}
