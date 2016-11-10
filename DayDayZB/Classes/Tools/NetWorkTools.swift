//
//  NetWorkTools.swift
//  封装数据解析
//
//  Created by 洛洛大人 on 16/11/9.
//  Copyright © 2016年 洛洛大人. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
    
}
class NetWorkTools: NSObject {

    class func requestData(type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finshedCallBack : @escaping (_ result : AnyObject) -> ()) {
    
        // 1.获取数据
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
         
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            // 4将结果回调出去
        finshedCallBack(result as AnyObject)
        }
        
        
    
    
    }
    
}
