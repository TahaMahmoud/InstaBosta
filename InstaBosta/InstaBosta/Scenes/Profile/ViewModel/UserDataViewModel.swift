//
//  UserDataViewModel.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation

class UserDataViewModel  {
    
    var id: Int?
    var name: String?
    var address: String?
    var phone: String?
    var website: String?
    
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.address = "\(user.address?.street ?? ""), \(user.address?.suite ?? ""), \(user.address?.city ?? "")"
        self.phone = user.phone ?? ""
        self.website = user.website ?? ""
    }
    
}
