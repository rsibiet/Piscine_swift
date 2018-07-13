//
//  listeDesLieux.swift
//  d05_mapKit
//
//  Created by Remy SIBIET on 11/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import Foundation
import CoreLocation

struct data {
    static let lieux : [(String, CLLocationCoordinate2D, String)] = [
        ("42", CLLocationCoordinate2D(latitude: 48.8966491, longitude: 2.31834989999993), "Best coding school ever"),
        ("Saint Ouen", CLLocationCoordinate2D(latitude: 48.911856, longitude: 2.3337639999999737), "Bof Country"),
        ("Grenoble", CLLocationCoordinate2D(latitude: 45.188529, longitude: 5.724523999999974), "Région Rhône-Alpes"),
        ("Reims", CLLocationCoordinate2D(latitude: 49.258329, longitude: 4.031696000000011), "Ville des Rois de France"),
        ("Moldavie", CLLocationCoordinate2D(latitude: 47.411631, longitude: 28.369885000000068), "Une terre qui se vide"),
        ("Circuit", CLLocationCoordinate2D(latitude: 47.9557312, longitude: 0.21215600000004997), "Des courses d'endurance")
    ]
    static var index : CFIndex = 0
}
