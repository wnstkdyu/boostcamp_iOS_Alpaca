//
//  ImageBoardTableViewController.swift
//  ImageBoard
//
//  Created by Alpaca on 2017. 8. 1..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ImageBoardTableViewController: UITableViewController {
    
    // MARK: Properties
    let baseURLString = ImageBoardAPI.baseURLString
    let request = Request()
    
    var articleInfo: [ArticleInfo] = []
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        startLoginView()
        getImageBoardData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func getImageBoardData() {
        guard let getURL = URL(string: baseURLString) else { return }
        request.get(url: getURL) {
            (data, response, error) -> Void in
            guard let data = data else { return }
            print(data)
            guard let imageBoardData  =  try? JSONDecoder().decode([ArticleInfo].self, from: data) else { return }
            print(imageBoardData)
            self.articleInfo = imageBoardData
            print(self.articleInfo)
        }
    }
    
    func startLoginView() {
        guard let loginViewController = storyboard?.instantiateViewController(
            withIdentifier: "NavigationController") else { return }
        present(loginViewController, animated: false, completion: nil)
    }
}

extension ImageBoardTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBoardCell",
                                                 for: indexPath) as? ImageBoardCell ?? ImageBoardCell()
        
        cell.imageview.image = getImageFromURL(imageURLString: articleInfo[indexPath.row].thumb_image_url) ?? nil
        cell.titleLabel.text = articleInfo[indexPath.row].image_title ?? ""
        cell.imageDescLabel.text = articleInfo[indexPath.row].image_desc ?? ""
        cell.dateLabel.text = String(describing: articleInfo[indexPath.row].created_at)
        
        return cell
    }
}

extension ImageBoardTableViewController {
    func getImageFromURL(imageURLString: String?) -> UIImage? {
        var resultImage = UIImage()
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
        guard let imageURLString = imageURLString else { return nil }
        guard let imageURL = URL(string: imageURLString + baseURLString) else { return UIImage() }
        let request = URLRequest(url: imageURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            OperationQueue.main.addOperation {
                guard let imageData = data else { return }
                guard let image = UIImage(data: imageData) else { return }
                resultImage = image
            }
        }
        task.resume()
        
        return resultImage
    }
}
