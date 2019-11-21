//
//  IpadViewController.swift
//  MaadJSON
//  Created by Noman Yousuf on 11/20/19.
//  Copyright © 2019 colors. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class IpadViewController: UITableViewController, UISplitViewControllerDelegate {
    
    // MARK: Properties at Class scope
    var relatedResult = [String]()
    var searching = false
    @IBOutlet weak var relatedSearch: UISearchBar!
    @IBOutlet weak var tableViewNew: UITableView!
    var relatedTextArray = [String]()
    var searchSegueIcon = [String]()
    

    // MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Split Controller setting
        splitViewController?.preferredDisplayMode = .allVisible
        splitViewController?.delegate = self
        //Searchbar
        relatedSearch.delegate = self
        //Json error handling
        let jsonRequestResult = jsonRequest()
        jsonRequestResult.getRelatedRecords{[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let recordsGet):
                self?.listOfRelatedTopics = recordsGet
            }
        }
        #if ipad
        print("ipad")
        #else
        print("iphone")
        #endif
        
        
        // Do any additional setup after loading the view, typically from a nib.

               let button = UIButton(type: .roundedRect)
               button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
               button.setTitle("Crash", for: [])
               button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
               view.addSubview(button)

           
    }

    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }
    //Setting up a array for rable view and also for search
    var listOfRelatedTopics = [RelatedTopic](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfRelatedTopics.count) Title found"
                
                for n in 0..<self.listOfRelatedTopics.count{
                    let temp = self.listOfRelatedTopics[n]
                    self.relatedTextArray.append(temp.text)
                    self.searchSegueIcon.append(temp.icon.url)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath)
        let detail = listOfRelatedTopics[indexPath.row]
        //Title split for table view
        let splitTheArray = detail.text.components(separatedBy: "- ")
       
        // MARK: Searching result
        //Searching
        if searching {
            //Title split for Search
            let arr1 = relatedResult[indexPath.row]
            //  let endOfSentence1 = arr1.firstIndex(of: "-")!
            guard (arr1.firstIndex(of: "-") != nil) else {
                return cell
            }
            let endOfSentence1 = arr1.firstIndex(of: "-")!
            let title1 = arr1[..<endOfSentence1]
            cell.textLabel?.text = String(title1)
        } else {
            
            #if ipad
            cell.textLabel?.text = String(splitTheArray[0])
            #else
            cell.textLabel?.text = String(splitTheArray[0])
            #endif
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return relatedResult.count
        } else {
            return listOfRelatedTopics.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "naviToDetail") as! DetailViewController
        let getCurrentRowIndex = self.tableView.indexPathForSelectedRow
        let detail = listOfRelatedTopics[getCurrentRowIndex!.row]
        
        //String Split for title
        let arr = detail.text
        guard (arr.firstIndex(of: "-") != nil) else {
            return print("")
        }
        let endOfSentence = arr.firstIndex(of: "-")!
        let title = arr[..<endOfSentence]
        
        
        // MARK: Searching result pass into detail VC
        //Searching
        if searching {
            //String split for detail
            let tempDetailArray = relatedResult[getCurrentRowIndex!.row].components(separatedBy: "- ")
            vc.stringForTitle = tempDetailArray[0]
            vc.stringForDetail = tempDetailArray[1]
            vc.stringForURL = detail.icon.url
        }
        // MARK: Passing result into detail VC
        else{
            //String split for detail
            let tempDetailArray = detail.text.components(separatedBy: "- ")
            vc.stringForTitle = String(title)
            vc.stringForDetail = tempDetailArray[1]
            vc.stringForURL = detail.icon.url
        }
        
        searching = false
        searchBarCancelButtonClicked(relatedSearch)
        //Show Detail VC
        splitViewController?.showDetailViewController(vc, sender: nil)
    }
    
    //Split View Delegate for showing master view at first(Not Working)
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}

// MARK: Searchbar Delegates with Extension
extension IpadViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        relatedResult = relatedTextArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableViewNew.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableViewNew.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
}


