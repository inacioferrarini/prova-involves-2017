//    The MIT License (MIT)
//
//    Copyright (c) 2017 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import Foundation
import CoreData

@objc(Episode)
public class Episode: NSManagedObject {

    open class func fetch(named name: String, with owner: Serie, in context: NSManagedObjectContext) -> Episode? {
        let request: NSFetchRequest = NSFetchRequest<Episode>(entityName: self.simpleClassName())
        let predicates = [
            NSPredicate(format: "name = %@", name),
            NSPredicate(format: "owner = %@", owner)
        ]
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return self.lastObject(from: request, in: context)
    }
    
    open class func episode(named name: String,
                            with owner: Serie,
                            airDate: NSDate,
                            order: Int16,
                            watched: Bool,
                            in context: NSManagedObjectContext) -> Episode? {
        let episode = self.fetch(named: name, with: owner, in: context)
        guard episode == nil else { return episode }
        
        guard let newEpisode = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? Episode else { return nil }
        
        newEpisode.name = name
        newEpisode.owner = owner
        newEpisode.airDate = airDate
        newEpisode.watched = watched
        newEpisode.order = order
        
        return newEpisode
    }
    
}
