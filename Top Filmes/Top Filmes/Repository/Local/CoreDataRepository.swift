//
//  CoreDataRepository.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataRepository {
    // MARK: - Constants
    struct Constants {
        static let entityName: String = "Movie"
    }
    
    static func saveMoviesBackup(movies: [MovieModel]) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: Constants.entityName)
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: context)
        
        for movie in movies {
            let predicate = NSPredicate(format: "id = '\(movie.id ?? 0)'")
            
            fetchRequest.predicate = predicate
            
            let object = try? context.fetch(fetchRequest)
            
            if !(object?.count ?? 0 > 0) {
                let movieObject = NSManagedObject(entity: entity!, insertInto: context)
                
                movieObject.setValue(movie.id, forKey: "id")
                movieObject.setValue(movie.vote_average, forKey: "vote_average")
                movieObject.setValue(movie.popularity, forKey: "popularity")
                movieObject.setValue(movie.title, forKey: "title")
                movieObject.setValue(movie.poster_path, forKey: "poster_path")
                movieObject.setValue(movie.original_language, forKey: "original_language")
                movieObject.setValue(movie.original_title, forKey: "original_title")
                movieObject.setValue(movie.backdrop_path, forKey: "backdrop_path")
                movieObject.setValue(movie.overview, forKey: "overview")
                movieObject.setValue(movie.release_date, forKey: "release_date")
                movieObject.setValue(movie.posterImage, forKey: "posterImage")
                movieObject.setValue(movie.backDropImage, forKey: "backDropImage")
                
                try? context.save()
            }
        }

        
    }
    
    static func getMoviesBackup() -> [MovieModel] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var moviesData = [MovieModel]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let movie = MovieModel()
                
                movie.id = data.value(forKey: "id") as? Double
                movie.vote_average = data.value(forKey: "vote_average") as? Float
                movie.popularity = data.value(forKey: "popularity") as? Float
                movie.title = data.value(forKey: "title") as? String
                movie.poster_path = data.value(forKey: "poster_path") as? String
                movie.original_language = data.value(forKey: "original_language") as? String
                movie.original_title = data.value(forKey: "original_title") as? String
                movie.backdrop_path = data.value(forKey: "backdrop_path") as? String
                movie.overview = data.value(forKey: "overview") as? String
                movie.release_date = data.value(forKey: "release_date") as? String
                movie.posterImage = data.value(forKey: "posterImage") as? Data
                movie.backDropImage = data.value(forKey: "BackDropImage") as? Data
                
                moviesData.append(movie)
            }
        } catch {
            print("Failed")
        }
        
        return moviesData.sorted(by: {$0.popularity ?? 0 > $1.popularity ?? 0})
    }
    
    static func updateMovieImage(movieId: Double, movieImageData: Data, isBackDrop: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: Constants.entityName)        
        let predicate = NSPredicate(format: "id = '\(movieId)'")
        
        fetchRequest.predicate = predicate
        
        do {
            let object = try context.fetch(fetchRequest)

            if object.count == 1 {
                let movieObject = object.first as! NSManagedObject
                
                if isBackDrop {
                    movieObject.setValue(movieImageData, forKey: "backDropImage")
                } else {
                    movieObject.setValue(movieImageData, forKey: "posterImage")
                }
            }
        } catch {
            print(error)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func clearStorage() {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
