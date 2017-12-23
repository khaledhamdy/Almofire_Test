//
//  TaskVC.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class TaskVC: UIViewController
{
    var taskArr = [Task]()
    var current_page:Int = 1
    var Last_Page:Int = 1
    //MARK: IBOutlet
    @IBOutlet var tableview: UITableView!
    struct Storyboard
    {
        static let taskCellIdentifier = "taskCell"
    }
    
    //MARK: Add Refresher To Page
    var refresher:UIRefreshControl =
    {
        var refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(TaskVC.handleRefrsh), for: .valueChanged)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refresher
    }()
    
    //MARK: Life-Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Tableview Properties
        tableview.dataSource = self
        tableview.delegate   = self
        tableview.addSubview(refresher)
        self.handleRefrsh()
    }
    
    //MARK: Helper Method .. ViewDidLoad
    @objc func handleRefrsh()
    {
        refresher.endRefreshing()
        API.taskAPI {(error:Error?, task:[Task]?,last_page:Int) in
            if let tasks = task{
                self.taskArr = tasks
                self.tableview.reloadData()
                self.current_page = 1
                self.Last_Page = last_page
            }
        }
    }
    
    //MARK: LoadMore() Func
    func loadMore()
    {
        guard current_page < Last_Page else {return}
        API.taskAPI(page: current_page+1) { (error:Error?, task:[Task]?, last_page:Int) in
            if let tasks = task{
                self.taskArr.append(contentsOf: tasks)
                self.tableview.reloadData()
                self.current_page += 1
                self.Last_Page = last_page
            }
        }
    }
    
    //MARK: Add Task To Server
    @IBAction func AddTaskAction(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add Item", message: "Add New Task", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        
        alert.addTextField { (configurationHandler) in
            configurationHandler.placeholder = "Add Task"
            configurationHandler.textAlignment = .center
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .destructive, handler: { (action) in
            guard let text = alert.textFields?.first?.text?.trimmed else {return}
            
            self.addTaskToServer(task:text)
        }))
        present(alert, animated: true, completion: nil)
    }
  
    fileprivate func addTaskToServer(task:String)
    {
        API.AddTaskAPI(task: task) { (error:Error?, tasks:Task?) in
            if let tasks = tasks
            {
                //ADD TO MODEL
                self.taskArr.insert(tasks, at: 0)
                //ADD TO TABLEVIEW
                self.tableview.beginUpdates()
                self.tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                self.tableview.endUpdates()
            }
            else
            {
                return
            }
        }
    }
}

//MARK: DataSource TableView
extension TaskVC:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return taskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.taskCellIdentifier, for: indexPath)
        let index = taskArr[indexPath.row]
        cell.textLabel?.text = index.task
        cell.backgroundColor = index.completed ? UIColor.yellow:UIColor.clear
        return cell
    }
    
    
}

//MARK: TableViewDelegate
extension TaskVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let count = self.taskArr.count
        if indexPath.row == count-1
        {
            self.loadMore()
        }
    }
    
    //MARK: Delete And Edit Action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let taskItem = taskArr[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexpath) in
            self.handleDelet(task: taskItem, indexpath: indexPath)
        }
        deleteAction.backgroundColor = UIColor.blue
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexpath) in
            self.handleEdit(task: taskItem, indexpath: indexPath)
        }
        
        
        return [deleteAction,editAction]
    }
    
    private func handleDelet(task:Task,indexpath:IndexPath)
    {
        API.deleteAPI(task: task) { (error:Error?, success:Bool?) in
            
            if success!
            {
                self.taskArr.remove(at: indexpath.row)
                self.tableview.beginUpdates()
                self.tableview.deleteRows(at: [indexpath], with: .automatic)
                self.tableview.endUpdates()
            }
            else
            {
                self.tableview.reloadData()
            }
            
        }
    }
    
    private func handleEdit(task:Task,indexpath:IndexPath)
    {
        let alert = UIAlertController(title: "Edit Task", message: "Enter Title", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        
        alert.addTextField { (configurationHandler) in
            configurationHandler.placeholder = "Add Task"
            configurationHandler.textAlignment = .center
            configurationHandler.text = task.task
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .destructive, handler: { (action) in
            guard let title = alert.textFields?.first?.text?.trimmed else {return}
            
            //send Edit Task To Sertver
            //Using Copy Of Task To Avoid
            //if An Error Occured in The Old Task
            let editedTask = task.copy() as! Task
            editedTask.task = title
            
            API.EditAPI(task: editedTask, complition: { (error:Error?, editedTask:Task?) in
                if let editedTask = editedTask
                {
                    //Add Edited Task To Model
                    //Delete Olded Task From Model
                    self.taskArr.remove(at: indexpath.row)
                    self.taskArr.insert(editedTask, at: indexpath.row)
                    
                    //Add Edited Task To TableView
                    self.tableview.beginUpdates()
                    self.tableview.reloadRows(at: [indexpath], with: .automatic)
                    self.tableview.endUpdates()
                }
                else
                {
                    //AAlerm
                }
            })
        }))
        present(alert, animated: true, completion: nil)
    }
}







