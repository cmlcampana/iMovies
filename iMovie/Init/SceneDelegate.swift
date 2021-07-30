//
//  SceneDelegate.swift
//  iMovie
//
//  Created by Camila Campana on 18/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let movieListViewController = MovieListFactory.make()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = movieListViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

