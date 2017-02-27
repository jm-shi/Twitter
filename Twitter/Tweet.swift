//
//  Tweet.swift
//  Twitter
//

import UIKit

class Tweet: NSObject {

    var currentUser: User?
    var text: String?
    var name: String?
    var username: String?
    var timestamp: Date?
    
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var didRetweet: Bool
    var didFavorite: Bool
    
    var timeSince: Int = 0
    var timeSinceAsString: String?
    
    let minute: Int = 60
    let hour: Int = 3600
    let day: Int = 86400
    
    func getRetweetCount() -> Int {
        return retweetCount
    }
    
    func getFavoritesCount() -> Int {
        return favoritesCount
    }
    
    func getRetweetStatus() -> Bool {
        return didRetweet
    }
    
    func getFavoriteStatus() -> Bool {
        return didFavorite
    }
    
    init(dictionary: NSDictionary)
    {
        currentUser = User(dictionary: dictionary["user"] as! NSDictionary)
        name = currentUser?.name
        username = "@" + (currentUser?.screenname)!
        
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        didRetweet = dictionary["retweeted"] as! Bool
        didFavorite = dictionary["favorited"] as! Bool
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as Date?
            
            timeSince = Int(Date().timeIntervalSince(timestamp!))
            if (timeSince < minute) {
                timeSinceAsString = String(timeSince) + "s"
            }
            else if (timeSince < hour) {
                timeSinceAsString = String(timeSince/minute) + "m"
            }
            else if (timeSince < day) {
                if (timeSince/hour == 1) {
                    timeSinceAsString = String(timeSince/hour) + "hr"
                }
                else {
                    timeSinceAsString = String(timeSince/hour) + "hrs"
                }
            }
            else {
                if (timeSince/day == 1) {
                    timeSinceAsString = String(timeSince/day) + "day"
                }
                else {
                    timeSinceAsString = String(timeSince/day) + "days"
                }
            }
        }

    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}