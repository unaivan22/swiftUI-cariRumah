//
//  DataModel.swift
//  carirumah (iOS)
//
//  Created by unaivan on 15/06/23.
//

import Foundation
struct Rumah: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Int
    let thumbnail: String
    let photoseller: String
    let seller: String
    let bedroom: Int
    let long: Int
    let wide: Int
    let bathroom: Int
    let kecamatan: String
    let kota: String
    let description: String
    
    }
