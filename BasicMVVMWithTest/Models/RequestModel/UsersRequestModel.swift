//
//  UsersRequestModel.swift
//  BasicMVVMWithTest
//
//  Created by Atakan Cengiz KURT on 24.07.2022.
//

import Foundation

final class UsersRequestModel: RequestModel {
    
    override init() { }
    
    override var path: String {
        Constant.API.users
    }
    
    override var method: RequestMethod {
        .get
    }
    
    
    
}
