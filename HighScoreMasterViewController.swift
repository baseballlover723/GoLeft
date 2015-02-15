import UIKit
import CoreData
import SpriteKit
class HighScoreMasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    //    var movieQuotes = [MovieQuote]()
    var MovieQuoteCount: Int{
        return fetchedResultsController.sections![0].numberOfObjects
    }
    func getMovieQuoteAtIndexPath(indexPath: NSIndexPath) -> Score {
        return fetchedResultsController.objectAtIndexPath(indexPath) as Score
    }
    var managedObjectContext : NSManagedObjectContext?
    let movieQuoteCellIdentifier = "HighScoreCell"
    let showDetailSegueIdentifier = "showDetailSegue"
    let noMovieQuoteCellIdentifier = "NoHighScoreCell"
    let movieQuoteEntityName = "MovieQuote"
    var bestScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddQuoteDialog")}
    
    func showAddQuoteDialog(){
        let alertController = UIAlertController(title: "Create a new movie quote", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Quote"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Movie Title"
        }
        
        
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: UIAlertActionStyle.Default) { (action) -> Void in
            println("You pressed create quote")
        
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
            
            
            let newMovieQuote = NSEntityDescription.insertNewObjectForEntityForName(self.movieQuoteEntityName, inManagedObjectContext: self.managedObjectContext!) as Score
            
            newMovieQuote.score = quoteTextField.tag
            newMovieQuote.userName = movieTextField.text
           // newMovieQuote.lastTouchDate = NSDate()
            
            self.saveManagedObjectContext()
            
        }
        alertController.addAction(createQuoteAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    func saveManagedObjectContext(){
        var error : NSError?
        managedObjectContext?.save(&error)
        if error != nil{
            abort()
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(MovieQuoteCount,1)
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
        case .Insert:
            if self.MovieQuoteCount == 1{
                self.tableView.reloadData()
            }else{
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        case .Delete:
            if MovieQuoteCount == 0{
                tableView.reloadData()
                setEditing(false, animated: true)
            }
            else{
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            }
        default:
            return
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        if MovieQuoteCount == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier(noMovieQuoteCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier(movieQuoteCellIdentifier, forIndexPath: indexPath) as UITableViewCell
            
            let movieQuote = getMovieQuoteAtIndexPath(indexPath)
          //  cell.textLabel?.text = movieQuote.score
            cell.detailTextLabel?.text = movieQuote.userName
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return MovieQuoteCount > 0
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if MovieQuoteCount == 0{
            super.setEditing(false, animated: false)
        }
        else{
            super.setEditing(editing, animated: animated)
        }
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest(entityName: movieQuoteEntityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "Score", ascending: false)]
        fetchRequest.fetchBatchSize = 20
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "MovieQuoteCache")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let movieQuoteToDelete = getMovieQuoteAtIndexPath(indexPath)
            managedObjectContext?.deleteObject(movieQuoteToDelete)
            
            saveManagedObjectContext()
        }
    }
    
    
}