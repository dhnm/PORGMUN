//
//  ViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 14.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit

class RulesTableViewController: UITableViewController, UISearchResultsUpdating {
  
  @IBOutlet var rulesTableView: UITableView!
  
  let rulesDict = [
    (
      section: "Points",
      items: [
        (
          name: "Point of Order",
          detail: "The Point of Order may be raised by any Delegate. It does not require a Second. It may only be raised if the there is a suspected breach of the Rules in the Committee. This Point may interrupt the Speaker. It is to be assessed by the Chair immediately."
        ), (
          name: "Point of Personal Privilege",
          detail: "The Point of Personal Privilege may be raised by any Delegate. It does not require a Second. It may only refer to comfort and well-being of the Delegate. This Point shall not interrupt the Speaker, unless it refers to their audibility."
        ), (
          name: "Point of Information",
          detail: "The Point of Information to the Speaker may only be raised when the Speaker opens themselves to Points of Information. It should have the form of a question. Speaker may choose whether they want to answer it. Dialogue on the floor is not allowed."
        ), (
          name: "Point of Information to the Chair",
          detail: "The Point of Information to the Chair may not interrupt the Speaker. It shall refer to order of proceedings, discussed matters, or anything else related to the conference. The Chair shall answer clearly and promptly and continue with the Agenda."
        )
      ]
    ), (
      section: "Motions",
      items: [
        (
          name: "Motion to Move to the Previous Question",
          detail: "This motion is used to move to the next question on the agenda. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Adjourn",
          detail: "A motion to adjourn meeting ends the committee session until the next session, which may be the next year’s conference, or after lunch. It requires a second and is then decided upon by the chair."
        ), (
          name: "Motion to Table",
          detail: "This motion is used to table (put on hold) all the work a committee has done concerning a particular issue, until it is decided a committee wants to return to the issue. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Move Directly into the Voting Procedure",
          detail: "This motion is used to move to the voting procedure. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Divide the House",
          detail: "Used in voting procedure, this motion allows for no abstentions. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Vote by Acclamation",
          detail: "Used in voting procedure, this motion allows for a passage of a proposal provided there are no objections. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Vote by Roll Call",
          detail: "Used in voting procedure, this motion means that voting will take place via roll call as explained in the Rules of Procedure. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion."
        ), (
          name: "Motion to Submit an Amendment",
          detail: "This motion is used when a participant of the debate wants to submit an amendment. It needs to be approved by the chair. Amendments will be dealt with in the order they were submitted unless provided otherwise. Amendments to the second degree and friendly amendments are in order."
        ), (
          name: "Motion to Extend Time",
          detail: "This motion is used when a participant of the debate wants to increase time spent on debating a given issue. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion. The chair sets the final time of the extension."
        ), (
          name: "Motion to Move into Closed/Open Debate",
          detail: "This motion is used to move into open/closed debate. Setting a time limit can be a part of raising this motion. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion. The chair sets the final time for the debate."
        ), (
          name: "Motion to Move into Unmoderated/Moderated Caucus",
          detail: "This motion is used to move into moderated/unmoderated caucus. Setting a time limit can be a part of raising this motion. It requires a second and is then decided upon by the chair. Well-founded objections fail this motion. The chair sets the final time for the caucus."
        )
      ]
    ), (
      section: "Rights",
      items: [
        (
          name: "Right to Follow-Up",
          detail: "After a point of information has been answered, a delegate may request a right to follow-up to ask a question regarding the answer to his previous question. This must be granted by the chair."
        ), (
          name: "Right of Reply",
          detail: "This right is exercised when a delegate feels that he, personally, or the country he represents has been offended by a participant of the debate. It is to be assessed by a chair immediately and if granted appropriate steps are to be taken (this can include requesting a formal apology or issuing a report to the secretariat)."
        )
      ]
    ), (
      section: "Order of Debate",
      items: [
        (
          name: "The Beginning",
          detail: "Announcement of the matter\n\nThe chair decides the first item on the agenda. Typically, this will be an announcement of the resolution to be debated.\n\nIntroduction of the matter\n\nThe proponent is summoned to the floor and asked to state what will be debated. Generally, this will be the the Main Submitter of a resolution reading aloud the Operative Clauses.\n\nChair sets debate time\n\nAn extension may be proposed by any delegate. Time runs continuously throughout the debate.\n\nIntroductory speech\n\nThe proponent will be given time to speak on the matter of debate. He may then open himself to points of information and/or yield the floor to another delegate."
        ), (
          name: "Open Debate",
          detail: "Delegates hold speeches\n\nDelegates who have the floor are allowed to address all matters relevant to the topic. They may introduce an amendment and open themselves to Points of Information. This process repeats until the set debate time has been exhausted."
        ), (
          name: "Closed Debate",
          detail: "Time in favour and time against\n\nThe designated number of delegates may now speak on the matter as a whole. Their speech may not extend the time limit determined by the chair. Points of Information are not allowed during this process."
        ), (
          name: "Voting",
          detail: "Voting rights:\n\nEach member of the committee shall have one vote.\n\nMajority required:\n\nDecisions of committees shall be made by a majority of the members present and voting. The phrase \"members present and voting\" means members casting an affirmative or negative vote. Members which abstain from voting are considered as not voting.\n\nMethod of voting:\n\nThe committee shall normally vote by show of placards or by standing unless moved otherwise.\n\nConduct during voting:\n\nAfter the Chairman has announced the beginning of voting, no representative shall interrupt the voting except on a point of order in connection with the actual conduct of the voting. The Chairman may permit members to explain their votes, either before or after the voting. The Chairman may limit the time to be allowed for such explanations. The Chairman shall not permit the proposer of a proposal or of an amendment to explain his vote on his own proposal or amendment."
        )
      ]
    ), (
      section: "Amendments",
      items: [
        (
          name: "Amendments",
          detail: "Amendments shall be submitted in writing during committee meetings. Amendments to the second degree and friendly amendments are in order."
        )
      ]
    )
  ]
  
  var filteredRules = [(section: String, items: [(name: String, detail: String)])]()
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    filteredRules = rulesDict
    
    searchController.searchResultsUpdater = self
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Rules"
    searchController.searchBar.tintColor = .black
    if #available(iOS 11.0, *) {
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
    } else {
      tableView.tableHeaderView = searchController.searchBar
    }
    definesPresentationContext = true
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text, !searchText.isEmpty {
      for (index, _) in filteredRules.enumerated() {
        filteredRules[index].items = rulesDict[index].items.filter { item in
          
          if item.name.lowercased().contains(searchText.lowercased()) || item.detail.lowercased().contains(searchText.lowercased()) {
            return true
          }
          return false
        }
      }
    } else {
      filteredRules = rulesDict
    }
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return filteredRules.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return filteredRules[section].section
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredRules[section].items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell", for: indexPath)
    let sectionCell = filteredRules[indexPath.section].items[indexPath.row]
    cell.textLabel?.text = sectionCell.name
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "rulesDetailSegue" {
      if let destinationVC: RulesDetailViewController = segue.destination as? RulesDetailViewController {
        let indexPath = self.rulesTableView.indexPathForSelectedRow!
        let sectionCell = filteredRules[indexPath.section].items[indexPath.row]
        destinationVC.data = (title: sectionCell.name, text: sectionCell.detail)
      }
    }
  }
}
