//
//  DetailTableOutput.swift
//  OrderNow
//
//  Created by ADMIN on 9/18/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class DetailTableOutput {
    init(_ chairs:Int,_ floor : Int,_ image:String,_ name : String,_ status:Int) {
        Chairs = chairs
        Floor = floor
        Image = image
        Name = name
        Status = status
    }
    var Chairs : Int!
    var Floor : Int!
    var Image : String!
    var Name : String!
    var Status : Int!
}
