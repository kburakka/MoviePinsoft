//
//  DetailViewController.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var movieDetail : MovieDetail?
    var countFired: CGFloat = 0
    var mirrorMovie : Mirror?
    var cellsToShow = [KeyValue]()
    
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imdbPoint: UILabel!
    @IBOutlet weak var ratingView: ProgressBar!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var blurImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellsToShow.removeAll()
        tableView.delegate = self
        tableView.dataSource = self
        
        setUI()
    }
}

extension DetailViewController{
    func setUI() {
        if let movieDetail = movieDetail{
            setImages(urlStr: movieDetail.Poster)
            setCellsToShow(movieDetail: movieDetail)
            setImdbRating(rating: movieDetail.imdbRating)
            
            titleLabel.text = movieDetail.Title
            genreLabel.text = movieDetail.Genre
        }
    }
    
    func setCellsToShow(movieDetail : MovieDetail){
        mirrorMovie = Mirror(reflecting: movieDetail)
        if let children = mirrorMovie?.children{
            for index in children{
                let value = "\(index.value)"
                if let label = index.label, label != "Title" && label != "Year" && label != "Genre" && label != "Poster" && label != "imdbID" && label != "imdbRating" && value != "N/A"{
                    cellsToShow.append(KeyValue(key: label, value: value))
                }
            }
        }
    }
    
    func setImages(urlStr :String){
        let url = URL(string: urlStr)
        posterImage.sd_setImage(with: url, placeholderImage: UIImage(named: "pinsoft"), options: SDWebImageOptions.highPriority, context: nil)
        blurImage.image = posterImage.image
        blurImage.addBlurEffect()
    }
    
    func setImdbRating(rating : String){
        if let imdbRating = Double(rating){
            imdbPoint.text = "\(imdbRating)"
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                self.countFired += 1
                
                DispatchQueue.main.async {
                    self.ratingView.progress = min(0.03 * self.countFired, CGFloat(imdbRating/10))
                    
                    if self.ratingView.progress >= CGFloat(imdbRating/10) {
                        timer.invalidate()
                    }
                }
            }
        }else{
            setImdbUI(isHidden: true)
        }
    }
    
    func setImdbUI(isHidden : Bool){
        imdbPoint.isHidden = isHidden
        ratingView.isHidden = isHidden
        imdbLabel.isHidden = isHidden
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailTableViewCell", owner: self, options: nil)?.first as! DetailTableViewCell
        cell.configure(keyValue: cellsToShow[indexPath.row])
        return cell
    }
}
