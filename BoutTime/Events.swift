//
//  Events.swift
//  BoutTime
//
//  Created by Eric Romanik on 2/8/18.
//  Copyright © 2018 Romanik. All rights reserved.
//

import GameKit
import AudioToolbox

var roundCount = 0
var correctRoundCount = 0
var roundOpenFlag = false
var gameRunningFlag = true

struct Event {
    let eventDescription: String
    let year: Int
    let webURL: String
}

// this object holds the set of events that is displayed and reordered during each round

struct EventRound {
    var events: [Event]
    func isOrderedCorrectly() -> Bool {
        if self.events[0].year < self.events[1].year && self.events[1].year < self.events[2].year && self.events[2].year < self.events[3].year {
            return true
        } else {
            return false
        }
    }
}

var roundEvents = EventRound(events:[])
var selectedEvent = Event(eventDescription: "", year: 0, webURL: "")

let eventData: [Event] = [
    Event(eventDescription: "Woodstock", year: 1969, webURL: "https://en.wikipedia.org/wiki/Woodstock"),
    Event(eventDescription: "Monterey Pop Festival", year: 1967, webURL: "https://en.wikipedia.org/wiki/Monterey_Pop_Festival"),
    Event(eventDescription: "The Beatles last concert", year: 1966, webURL: "https://en.wikipedia.org/wiki/The_Beatles"),
    Event(eventDescription: "Live Aid", year: 1985, webURL: "https://en.wikipedia.org/wiki/Live_Aid"),
    Event(eventDescription: "Jimi Hendrix dies", year: 1970, webURL: "https://en.wikipedia.org/wiki/Jimi_Hendrix"),
    Event(eventDescription: "Jim Morrison dies", year: 1971, webURL: "https://en.wikipedia.org/wiki/Jim_Morrison"),
    Event(eventDescription: "MTV launches", year: 1981, webURL: "https://en.wikipedia.org/wiki/MTV"),
    Event(eventDescription: "Kurt Cobain commits suicide", year: 1994, webURL: "https://en.wikipedia.org/wiki/Kurt_Cobain"),
    Event(eventDescription: "Stevie Ray Vaughan dies", year: 1990, webURL: "https://en.wikipedia.org/wiki/Stevie_Ray_Vaughan"),
    Event(eventDescription: "Bob Dylan first plays electric guitar live", year: 1965, webURL: "https://en.wikipedia.org/wiki/Bob_Dylan"),
    Event(eventDescription: "Pete Townshend first smashes his guitar", year: 1964, webURL: "https://en.wikipedia.org/wiki/Pete_Townshend"),
    Event(eventDescription: "Fender Stratocaster guitar introduced", year: 1954, webURL: "https://en.wikipedia.org/wiki/Fender_Stratocaster"),
    Event(eventDescription: "Gibson Les Paul guitar introduced", year: 1954, webURL: "https://en.wikipedia.org/wiki/Gibson_Les_Paul"),
    Event(eventDescription: "Elvis Presley dies", year: 1977, webURL: "https://en.wikipedia.org/wiki/Elvis_Presley"),
    Event(eventDescription: "John Lennon assassinated", year: 1980, webURL: "https://en.wikipedia.org/wiki/John_Lennon"),
    Event(eventDescription: "Lennon meets McCartney", year: 1957, webURL: "https://en.wikipedia.org/wiki/The_Beatles"),
    Event(eventDescription: "Elvis Presley drafted into the Army", year: 1958, webURL: "https://en.wikipedia.org/wiki/Elvis_Presley"),
    Event(eventDescription: "Buddy Holly and Richie Valens die in plane crash", year: 1959, webURL: "https://en.wikipedia.org/wiki/The_Day_the_Music_Died"),
    Event(eventDescription: "Jimi Hendrix enlists in the Army", year: 1961, webURL: "https://en.wikipedia.org/wiki/Jimi_Hendrix"),
    Event(eventDescription: "David Bowie dies", year: 2016, webURL: "https://en.wikipedia.org/wiki/David_Bowie"),
    Event(eventDescription: "Michael Jackson dies", year: 2009, webURL: "https://en.wikipedia.org/wiki/Michael_Jackson"),
    Event(eventDescription: "Freddie Mercury dies", year: 1991, webURL: "https://en.wikipedia.org/wiki/Freddie_Mercury"),
    Event(eventDescription: "Guitar Hero released", year: 2005, webURL: "https://en.wikipedia.org/wiki/Guitar_Hero"),
    Event(eventDescription: "Chuck Berry dies", year: 2017, webURL: "https://en.wikipedia.org/wiki/Chuck_Berry"),
    Event(eventDescription: "Jerry Garcia dies", year: 1995, webURL: "https://en.wikipedia.org/wiki/Jerry_Garcia"),
    Event(eventDescription: "Ozzy Osbourne bites head off of bat", year: 1982, webURL: "https://en.wikipedia.org/wiki/Ozzy_Osbourne"),
    Event(eventDescription: "Purple Rain released (movie/album)", year: 1984, webURL: "https://en.wikipedia.org/wiki/Purple_Rain"),
    Event(eventDescription: "Jimi Hendrix plays first gig", year: 1960, webURL: "https://en.wikipedia.org/wiki/Jimi_Hendrix"),
    Event(eventDescription: "Keith Moon dies", year: 1978, webURL: "https://en.wikipedia.org/wiki/Keith_Moon"),
    Event(eventDescription: "Joe Cocker dies", year: 2014, webURL: "https://en.wikipedia.org/wiki/Joe_Cocker"),
    Event(eventDescription: "Prince changes his name to an unpronouncable symbol", year: 1993, webURL: "https://en.wikipedia.org/wiki/Prince"),
]

var events: [Event] = []

func generateEventRound() -> EventRound {
    var eventRoundArray = EventRound(events: [])
    events = []
    events.append(contentsOf: eventData)
    for _ in 1...4 {
        let indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: events.count)
        eventRoundArray.events.append(events[indexOfSelectedEvent])
        events.remove(at: indexOfSelectedEvent)
    }
    return eventRoundArray
}


