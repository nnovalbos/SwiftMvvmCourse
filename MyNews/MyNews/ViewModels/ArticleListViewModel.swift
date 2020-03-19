//
//  ArticleListViewModel.swift
//  MyNews
//
//  Created by Nicolas Novalbos on 17/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    let articles : [Article]
}

extension ArticleListViewModel {
    
    var numSections : Int {
        return 1;
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex (_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}
