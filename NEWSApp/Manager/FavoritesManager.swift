//
//  FavoritesManager.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 04/11/2023.
//

import UIKit


final class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteArticles"
    
    func addFavorite(_ article: Articles) {
        var favorites = getFavorites()
        favorites.append(article)
        saveFavorites(favorites)
    }
    
    func removeFavorite(_ article: Articles) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(where: { $0.url == article.url }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }
    
    func isArticleFavorited(_ article: Articles) -> Bool {
            let favorites = getFavorites()
            return favorites.contains { $0.url == article.url }
        }
    
    func getFavorites() -> [Articles] {
        if let data = userDefaults.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode([Articles].self, from: data) {
            return favorites.reversed()
        }
        return []
    }
    
    private func saveFavorites(_ favorites: [Articles]) {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
