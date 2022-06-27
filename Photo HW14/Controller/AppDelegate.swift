//
//  AppDelegate.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let tabBarController = UITabBarController()

               let mediaLibrary = UIViewController()
               mediaLibrary.tabBarItem = UITabBarItem(title: "Медиатека", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
               mediaLibrary.view.backgroundColor = .white

               let mediaLibraryNavigationController = UINavigationController(rootViewController: mediaLibrary)

               let forYou = UIViewController()
               forYou.tabBarItem = UITabBarItem(title: "Для Вас", image: UIImage(systemName: "heart.text.square.fill"), tag: 1)
               forYou.view.backgroundColor = .white
               let forYouNavigationController = UINavigationController(rootViewController: forYou)

               let albums = ViewController()
               albums.tabBarItem = UITabBarItem(title: "Альбомы", image: UIImage(systemName: "square.stack.fill"), tag: 2)
               albums.view.backgroundColor = .white
               let albumsNavigationController = UINavigationController(rootViewController: albums)

               let search = UIViewController()
               search.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 3)
               search.view.backgroundColor = .white
               let searchNavigationController = UINavigationController(rootViewController: search)


               tabBarController.setViewControllers([
                   mediaLibraryNavigationController,
                   forYouNavigationController,
                   albumsNavigationController,
                   searchNavigationController,

               ], animated: true)

               window?.rootViewController = tabBarController
               window?.makeKeyAndVisible()
               return true
           }
}

