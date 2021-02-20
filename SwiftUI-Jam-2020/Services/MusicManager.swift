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
        
        player.prepareToPlay()
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
    
    func stop() {
        player.stop()
    }
    
    func getPlaylists() -> [MPMediaItemCollection] {
        let playlists = MPMediaQuery.playlists()
        let collections = playlists.collections
        return collections ?? [MPMediaItemCollection]()
    }
    
    func getAllSongs() -> [MPMediaItem] {
        let songs = MPMediaQuery.songs().items
        return songs ?? [MPMediaItem]()
    }
    
    func playSong(id: String) {
        player.setQueue(with: [id])
        player.play()
    }
    
    func playShuffledSongs() {
        let allSongs = getAllSongs()
        var shuffledIDs = [String]()
        let shuffled = allSongs.shuffled()
        for song in shuffled {
            shuffledIDs.append(song.playbackStoreID)
        }
        player.setQueue(with: shuffledIDs)
        player.play()
    }
    var disposal = Set<AnyCancellable>()
    func nowPlayingChanged() -> AnyPublisher<Notification, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
            .eraseToAnyPublisher()
    }
    func queueChanged() -> AnyPublisher<Notification, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.MPMusicPlayerControllerQueueDidChange)
            .eraseToAnyPublisher()
           
    }
   
    func libraryChanged() -> AnyPublisher<Notification, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.MPMediaLibraryDidChange)
            .eraseToAnyPublisher()
          
       
    } 
    func volumeChanged() -> AnyPublisher<Notification, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.MPMusicPlayerControllerVolumeDidChange)
            .eraseToAnyPublisher()
            
    }
}
