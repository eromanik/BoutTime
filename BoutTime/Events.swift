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

struct Event {
    let eventDescription: String
    let year: Int
}

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

let eventData: [Event] = [
    Event(eventDescription: "Woodstock", year: 1969),
    Event(eventDescription: "Monterey Pop Festival", year: 1967),
    Event(eventDescription: "The Beatles last concert", year: 1966),
    Event(eventDescription: "Live Aid", year: 1985),
    Event(eventDescription: "Jimi Hendrix dies", year: 1970),
    Event(eventDescription: "Jim Morrison dies", year: 1971),
    Event(eventDescription: "MTV launches", year: 1981),
    Event(eventDescription: "Kurt Cobain commits suicide", year: 1994),
    Event(eventDescription: "Stevie Ray Vaughan dies", year: 1990),
    Event(eventDescription: "Bob Dylan first plays electric guitar live", year: 1965),
    Event(eventDescription: "Pete Townshend first smashes his guitar", year: 1964),
    Event(eventDescription: "Fender Stratocaster introduced", year: 1954),
    Event(eventDescription: "Elvis Presley dies", year: 1977),
    Event(eventDescription: "John Lennon assassinated", year: 1980),
    Event(eventDescription: "Lennon meets McCartney", year: 1957),
    Event(eventDescription: "Elvis Presley drafted into the Army", year: 1958),
    Event(eventDescription: "Buddy Holly and Richie Valens die in plane crash", year: 1959),
    Event(eventDescription: "Jimi Hendrix enlists in the Army", year: 1961),
    Event(eventDescription: "Prince and David Bowie die", year: 2016),
    Event(eventDescription: "Michael Jackson dies", year: 2009),
    Event(eventDescription: "Freddie Mercury dies", year: 1991),
    Event(eventDescription: "Guitar Hero released", year: 2005),
    Event(eventDescription: "Chuck Berry dies", year: 2017),
    Event(eventDescription: "Jerry Garcia dies", year: 1995),
    Event(eventDescription: "Ozzy Osbourne bites head off of bat", year: 1982),
    Event(eventDescription: "Purple Rain released (movie/album)", year: 1984),
    Event(eventDescription: "Jimi Hendrix plays first gig", year: 1960),
    Event(eventDescription: "Keith Moon dies", year: 1978),
    Event(eventDescription: "Joe Cocker dies", year: 2014),
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


