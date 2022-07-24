//
//  AlbumsRequestModel.swift
//  BasicMVVMWithTest
//
//  Created by Atakan Cengiz KURT on 24.07.2022.
//

import Foundation

final class AlbumsRequestModel: RequestModel {
    
    private let userId : Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    override var path: String {
        Constant.API.albums
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?]{
        [ "userId" : String(self.userId) ]
    }
    
}
