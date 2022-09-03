//
//  AppData.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import Foundation

class AppData: ObservableObject {
    
    @Published var spots: [Spot] = []
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("becareful.data")
    }
    
    init() {
        #if DEBUG
        self.spots = Spot.mocks
        #else
        self.load()
        #endif
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return
            }
            
            guard let spots = try? JSONDecoder().decode([Spot].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            
            DispatchQueue.main.async {
                self?.spots = spots
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let spots = self?.spots else { fatalError("Self out of scope") }
            
            guard let data = try? JSONEncoder().encode(spots) else { fatalError("Error encoding data") }
            
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
            
        }
    }
    
}
