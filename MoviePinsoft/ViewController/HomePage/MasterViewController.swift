//
//  MasterViewController.swift
//  MoviePinsoft
//
//  Created by burak kaya on 26/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var message = ""{
        didSet{
            setMessages()
        }
    }
    
    var searchResults = [SearchMovie](){
        didSet{
            if searchResults.count != 0{
                tableView.hideMessage()
            }
        }
    }
    
    var searchText = ""{
        didSet{
            LoadingView(view: view).startAnimation()
            getMovies(searchText: searchText) {
                LoadingView(view: self.view).stopAnimation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMessages()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension MasterViewController{
    func setMessages(){
        if searchText == ""{
            tableView.showMessage(message: "Please type movie name.", containerView: self.tableView)
        }else{
            tableView.showMessage(message: message, containerView: self.tableView)
        }
    }
    
    func getMovies(searchText : String, completion: @escaping () -> Void){
        guard let escapedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion()
            return
        }
        APIClient.getSearchMovie(searchText: escapedString) { (result,error)  in
            if let error = error{
                self.searchResults.removeAll()
                switch error {
                case .success(let error):
                    self.message = error.Error
                case .failure(let error):
                    self.message = error.localizedDescription
                }
            }else{
                switch result {
                case .success(let searchMovie):
                    self.searchResults = searchMovie.Search
                case .failure(let error):
                    self.searchResults.removeAll()
                    self.message = error.localizedDescription
                case .none:
                    self.searchResults.removeAll()
                    self.message = "Something went wrong."
                }
            }
            self.tableView.reloadData()
            completion()
        }
    }
}

extension MasterViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension MasterViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as! SearchTableViewCell
        
        cell.configure(movie: searchResults[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
}
