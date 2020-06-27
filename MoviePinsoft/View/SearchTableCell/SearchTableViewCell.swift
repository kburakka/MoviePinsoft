//
//  SearchTableViewCell.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(movie : SearchMovie){
        title.text = movie.Title
        year.text = movie.Year
        let url = URL(string: movie.Poster)
        movieImage?.sd_setImage(with: url, placeholderImage: UIImage(named: "pinsoft"), options: SDWebImageOptions.highPriority, context: nil)
    }
}
