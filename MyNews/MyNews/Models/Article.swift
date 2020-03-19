//
//  Article.swift
//  MyNews
//
//  Created by Nicolas Novalbos on 17/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct ArticleList : Decodable {
    let articles : [Article]
}

struct Article : Decodable {
    let title : String
    let description : String?
}
