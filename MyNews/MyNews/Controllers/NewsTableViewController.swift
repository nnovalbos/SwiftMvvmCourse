//
//  NewsTableViewController.swift
//  MyNews
//
//  Created by Nicolas Novalbos on 16/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

public class NewsTableViewController : UITableViewController {
    
    private let API_KEY = "your_api_key"
    
    private var articleListViewModel : ArticleListViewModel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "http://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)")!
        
        NewsService().getArticles(url: url) { articles in
            
            if let articles = articles {
                self.articleListViewModel = ArticleListViewModel(articles: articles)
                
                //refrescamos la lista
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.numSections
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.numberOfRowsInSection(section)
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellId", for: indexPath) as? ArticleTableViewCell else{
            fatalError("ArticleCellId not found")
        }
        
        let articleViewMode = self.articleListViewModel.articleAtIndex(indexPath.row)
        
        cell.titleLabel.text = articleViewMode.title
        cell.descriptionLabel.text = articleViewMode.description
        
        return cell
        
    }
}
