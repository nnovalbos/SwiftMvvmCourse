//
//  ArticleViewModel.swift
//  MyNews
//
//  Created by Nicolas Novalbos on 17/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    private let article : Article
}

extension ArticleViewModel {
    init(_ article : Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title : String {
        return self.article.title
    }
    
    var description : String {
        return self.article.description ?? "No description available"
    }
}
