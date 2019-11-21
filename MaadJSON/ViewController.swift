//
//  ViewController.swift
//  MaadJSON
//
//  Created by Noman Yousuf on 11/18/19.
//  Copyright © 2019 colors. All rights reserved.
//

import Foundation
import UIKit

//class ViewController: UITableViewController {
//
//    
//    var relatedResult = [String]()
//    var searching = false
//    @IBOutlet weak var relatedSearch: UISearchBar!
//    @IBOutlet weak var tableViewNew: UITableView!
//    var relatedTextArray = [String]()
//    var searchSegueIcon = [String]()
//    
//    
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//     
//     relatedSearch.delegate = self
//        
//        let jsonRequestResult = jsonRequest()
//               jsonRequestResult.getRelatedRecords{[weak self] result in
//                   switch result{
//                   case .failure(let error):
//                       print(error)
//                   case .success(let recordsGet):
//                       self?.listOfRelatedTopics = recordsGet
//                     }
//                 }
//     
//     #if ipad
//     print("ipad")
//     #else
//     print("iphone")
//     #endif
//        
//        
//        
//        
//        
//     
//         }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    var listOfRelatedTopics = [RelatedTopic](){
//           didSet{
//               DispatchQueue.main.async {
//                   self.tableView.reloadData()
//                   self.navigationItem.title = "\(self.listOfRelatedTopics.count) Title found"
//                
//                for n in 0..<self.listOfRelatedTopics.count{
//                    let temp = self.listOfRelatedTopics[n]
//                    self.relatedTextArray.append(temp.text)
//                    self.searchSegueIcon.append(temp.icon.url)
//                     }
//               }
//           }
//       }
//
//
//     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
//            let detail = listOfRelatedTopics[indexPath.row]
//        
//           
//        
//              
//            //Title split for table view
//            let splitTheArray = detail.text.components(separatedBy: "- ")
//        
//        
//        if searching {
//            
//                    //Title split for Search
//                   let arr1 = relatedResult[indexPath.row]
//                 //  let endOfSentence1 = arr1.firstIndex(of: "-")!
//                   guard (arr1.firstIndex(of: "-") != nil) else {
//                           return cell
//                       }
//                   let endOfSentence1 = arr1.firstIndex(of: "-")!
//                   let title1 = arr1[..<endOfSentence1]
//                  let title2 = arr1[endOfSentence1...]
//                  cell.titleLabel.text = String(title1)
//                  cell.detailLabel.text = String(title2)
//                    
//               } else {
//                   
//            
//            
//                        #if ipad
//                       cell.titleLabel.text = String(splitTheArray[0])
//            
//                        if splitTheArray.count<2 {
//                            print("Index out of range for detail.")
//                            //cell.detailLabel.text = detail.text
//                            }else{
//                                cell.detailLabel.text = String(splitTheArray[1])
//                            }
//            
//            if let url = URL(string: detail.icon.url){
//                  func setImage(from url: String) {
//                      guard let imageURL = URL(string: url) else { return }
//
//                          // just not to cause a deadlock in UI!
//                      DispatchQueue.global().async {
//                          guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//                          let image = UIImage(data: imageData)
//                          DispatchQueue.main.async {
//                              cell.profileImage.image = image
//                        }
//                      }
//                  }
//                  setImage (from: detail.icon.url)
//                  }
//                  else{
//
//                      cell.profileImage.image = UIImage(systemName: "person.crop.circle.fill.badge.exclam")
//                  }
//            
//            cell.titleLabel.font = cell.titleLabel.font.withSize(24)
//            cell.titleLabel.textColor = .systemPink
//                       #else
//                       cell.titleLabel.text = String(splitTheArray[0])
//            
//            
//            //Hide image
//            cell.profileImage.isHidden = true
//            cell.detailLabel.isHidden = true
//                       #endif
//               }
//        
//            return cell
//        }
//        
//        
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            
//            if searching {
//                return relatedResult.count
//            } else {
//                 return listOfRelatedTopics.count
//            }
//           
//        }
//    
//        
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "naviToDetail"{
//            let detailViewController = segue.destination as! DetailViewController
//            let getCurrentRowIndex = self.tableView.indexPathForSelectedRow
//            let detail = listOfRelatedTopics[getCurrentRowIndex!.row]
//            
//
//            //String Split for title
//            let arr = detail.text
//            
//            guard (arr.firstIndex(of: "-") != nil) else {
//                return print("")
//            }
//            let endOfSentence = arr.firstIndex(of: "-")!
//            let title = arr[..<endOfSentence]
//            
//            
//             if searching {
//            //String split for detail
//             let tempDetailArray = relatedResult[getCurrentRowIndex!.row].components(separatedBy: "- ")
//            detailViewController.stringForTitle = tempDetailArray[0]
//            detailViewController.stringForDetail = tempDetailArray[1]
//            
//                detailViewController.stringForURL = detail.icon.url
//
//            
//            }
//            
//             else{
//                //String split for detail
//                        let tempDetailArray = detail.text.components(separatedBy: "- ")
//                        detailViewController.stringForTitle = String(title)
//                        detailViewController.stringForDetail = tempDetailArray[1]
//                        
//                        //Set a URL value
//                        detailViewController.stringForURL = detail.icon.url
//            }
//                
//        }
//        searching = false
//        searchBarCancelButtonClicked(relatedSearch)
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        #if ipad
//        return 183
//        #else
//        return 75
//        #endif
//    }
//
//    
//    
//    
//
//
//    
//    
//    
//}
//
//extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        // searchSegueIcon.append(detail.icon.url)
//
//        print(relatedTextArray.count)
//        print(relatedTextArray)
//        
//       // relatedResult = RelatedTopic({($0 as AnyObject).prefix(searchText.count) == searchText.lowercased()})
//
//        //var temp = listOfRelatedTopics.filter({_ in (searchText.count) == searchText.lowercased()})
//        
//       // relatedResult = temp.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
//        
//        
////        var temp = listOfRelatedTopics
////
////
////        for n in 0..<self.listOfRelatedTopics.count{
////            let temp1 = self.listOfRelatedTopics[n]
////
////
////            relatedResult = [temp1.text.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})]
////            relatedResult = [temp1.icon.url.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})]
////            print(relatedResult)
////
////             }
////
//        
//
//    
//        
//        relatedResult = relatedTextArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
//        searching = true
//        tableViewNew.reloadData()
//        
//        
//        
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//          searching = false
//          searchBar.text = ""
//          searchBar.resignFirstResponder()
//          tableViewNew.reloadData()
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//        //searching = false
//       // searchBar.text = ""
//        searchBar.resignFirstResponder()
//       // tableViewNew.reloadData()
//    }
//
//}
//
//
