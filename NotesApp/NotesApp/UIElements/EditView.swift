//
//  EditView.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 23.03.2021.
//

import SwiftUI
import Alamofire

struct EditView: View {
    
    //to call onDismiss function on the sheet
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var txt: String
    @Binding var noteID: String
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack{
                MultiLineTF(txt: $txt).padding([.horizontal, .top]).background(Color.black.opacity(0.05))
            }
            Button(action: {
                show.toggle()
                SaveData()
            }, label: {
                Text("Save").bold().padding(.vertical).padding(.horizontal, 50).foregroundColor(.white)
            }).background(Color(.blue))
            .clipShape(Capsule())
            .padding()
            .padding()
        }.edgesIgnoringSafeArea(.bottom)
        
    }
    
    // MARK: - Saving or Updating Notes
    func SaveData() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YY  hh:mm a"
        let dateString = formatter.string(from: Date())
        
        //updating if the noteId is provided
        if noteID != "" {
            
            let parameters: [String: String] = [
                "id" : "\(noteID)",
                "date" : "\(dateString)",
                "note" : "\(txt)"
            ]
            
            AF.request(Constants.API, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                
                switch response.result {
                
                case .failure(let error):
                    print("Error updating the note: \(error)")
                    
                case .success(let value):
                    print("Note updated: \(value)")
                }
            }
        } else {
            //creating a new note
            let parameters: [String: String] = [
                "date" : "\(dateString)",
                "note" : "\(txt)"
            ]
            
            AF.request(Constants.API, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                
                switch response.result {
                
                case .failure(let error):
                    print("Error creating the note: \(error)")
                    
                case .success(let value):
                    print("Note saved: \(value)")
                }
            }
        }
        //dismissing the sheet
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(txt: .constant(""), noteID: .constant(""), show: .constant(true)).previewDevice("iPhone 11 Pro Max")
    }
}
