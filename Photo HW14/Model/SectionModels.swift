//
//  SectionModels.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import Foundation

enum Section: Int, CaseIterable {
case myAlbums
case peopleAndPlaces
case mediaFileTypes
case otherImage

 func createHeaderSection () -> String {
        switch self {
        case .myAlbums:
            return "Мои альбомы"
        case .peopleAndPlaces:
            return "Люди и места"
        case .mediaFileTypes:
            return "Типы медиафайлов"
        case .otherImage:
            return "Другое"
        }
    }
}
