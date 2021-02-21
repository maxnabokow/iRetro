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
    
    private let player: MPMusicPlayerController
    
    var playState: MPMusicPlaybackState {
        player.playbackState
    }
    
    var nowPlayingItem: MPMediaItem? {
        player.nowPlayingItem
    }
    
    private init() {
        player = MPMusicPlayerController.systemMusicPlayer
        player.beginGeneratingPlaybackNotifications()
    }
    
    func play() {
        player.play()
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
        player.skipToBeginning()
    }

    func currentTimeInSong() -> TimeInterval {
        return player.currentPlaybackTime
    }

    func totalTimeInSong() -> TimeInterval {
        return player.nowPlayingItem!.playbackDuration
    }
    
    func getPlaylists() -> [MPMediaPlaylist] {
        let playlists = MPMediaQuery.playlists()
        let collections = playlists.collections as? [MPMediaPlaylist]
        return collections ?? [MPMediaPlaylist]()
    }
    
    func getAllSongs() -> [MPMediaItem] {
        let songs = MPMediaQuery.songs().items
        return songs ?? [MPMediaItem]()
    }
    
    func getArtists() -> [MPMediaItem] {
        let artists = MPMediaQuery.artists().items
        return artists ?? [MPMediaItem]()
    }
    
    func getAlbums() -> [MPMediaItem] {
        let albums = MPMediaQuery.albums().items
        return albums ?? [MPMediaItem]()
    }
    
    func getCompilations() -> [MPMediaItem] {
        let complications = MPMediaQuery.compilations().items
        return complications ?? [MPMediaItem]()
    }
    
    func getGenres() -> [MPMediaItem] {
        let genres = MPMediaQuery.genres().items
        return genres ?? [MPMediaItem]()
    }
    
    func getComposers() -> [MPMediaItem] {
        let composers = MPMediaQuery.composers().items
        return composers ?? [MPMediaItem]()
    }
    
    func getAudiobooks() -> [MPMediaItem] {
        let books = MPMediaQuery.audiobooks().items
        return books ?? [MPMediaItem]()
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

    func playFavoriteSong() {
        let songs = getAllSongs()
        var songsPlayCount = [Int]()
        var favSongID = ""
        for song in songs {
            songsPlayCount.append(song.playCount)
            if songsPlayCount.max() == song.playCount {
                favSongID = song.playbackStoreID
            }
        }
        
        player.setQueue(with: [favSongID])
        player.play()
    }
    
    func setQueue(with collection: MPMediaItemCollection) {
        player.setQueue(with: collection)
    }
    func playArtistsSongs(artist: MPMediaItem)  {
        let songs = getAllSongs()
        var filteredSongs = [MPMediaItem]()
       
        for song in songs {
            if song.artist == artist.artist {
                filteredSongs.append(song)
            }
        }
        
        setQueue(with: MPMediaItemCollection(items: filteredSongs))
        player.play()
    }
    private var sinks = Set<AnyCancellable>()
    
    func playStateChanged() -> AnyPublisher<MPMusicPlaybackState, Never> {
        return NotificationCenter.default
            .publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)
            .map { _ in
                self.playState
            }
            .eraseToAnyPublisher()
    }
    
    func nowPlayingChanged() -> AnyPublisher<Void, Never> {
        return NotificationCenter.default
            .publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    func queueChanged() -> AnyPublisher<Void, Never> {
        return NotificationCenter.default
            .publisher(for: .MPMusicPlayerControllerQueueDidChange)
            .map { _ in }
            .eraseToAnyPublisher()
    }
   
    #warning("Doesn't work yet")
    func libraryChanged() -> AnyPublisher<Void, Never> {
        return NotificationCenter.default
            .publisher(for: .MPMediaLibraryDidChange)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    func volumeChanged() -> AnyPublisher<Void, Never> {
        return NotificationCenter.default
            .publisher(for: .MPMusicPlayerControllerVolumeDidChange)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
