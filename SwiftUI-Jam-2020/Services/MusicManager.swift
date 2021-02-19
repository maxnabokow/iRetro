//
//  MusicManager.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import Foundation
import MediaPlayer

class MusicManager {
    static let shared = MusicManager()
    
    let player: MPMusicPlayerController
    
    private init() {
        player = MPMusicPlayerController.systemMusicPlayer
        player.beginGeneratingPlaybackNotifications()
    }
    
    func playPause() {
        if player.playbackState == .playing {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func next() {
        player.skipToNextItem()
    }
    
    func previous() {
        if player.currentPlaybackTime <= 5 {
            player.skipToPreviousItem()
        } else {
            player.skipToBeginning()
        }
    }
    
    func getPlaylists() -> [MPMediaItemCollection]  {
        let playlists = MPMediaQuery.playlists()
        let collections = playlists.collections
        return collections ?? [MPMediaItemCollection]()
    }
    
    func getAllSongs() -> [MPMediaItem]  {
        let songs = MPMediaQuery.songs()
        let items = songs.items
        return items ?? [MPMediaItem]()
    }
    
    func playSong(id: String) {
        player.setQueue(with: [id])
        player.play()
    }
    
    func shuffleAllSongs() {
        let allSongs = getAllSongs()
        var suffledIDs = [String]()
        let suffled = allSongs.shuffled()
        for song in suffled {
            suffledIDs.append(song.playbackStoreID)
        }
        player.setQueue(with: suffledIDs)
        player.play()
    }
    
    func nowPlayingChanged() -> AnyPublisher<Notification, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
            .eraseToAnyPublisher()
    }
}
