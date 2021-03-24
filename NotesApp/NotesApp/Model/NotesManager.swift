//
//  NotesManager.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 23.03.2021.
//

import Foundation
import Alamofire

class NotesViewModel: ObservableObject {
    
    @Published var data = [Note]()
    @Published var noData = false
    
    init(){
        fetchNotes()
    }
    
    func fetchNotes(){
        AF.request(Constants.API, method: .get).response { [self] response in
            
            switch response.result {
            
            case .failure(let error):
                print("Error fetching the data: \(error)")
                
            case .success(let value):
                if value == nil{
                    noData = true
                    return
                }
                do {
                    data = try JSONDecoder().decode([Note].self, from: value!)
                    if data.count == 0 {
                        noData = true
                        return
                    }
                } catch {
                    print("Failed to decode")
                }
            }
        }
    }
}
