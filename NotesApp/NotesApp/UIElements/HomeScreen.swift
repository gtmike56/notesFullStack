//
//  HomeScreen.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 23.03.2021.
//

import SwiftUI
import Alamofire

struct HomeScreen: View {
    
    // MARK: - Initialization
    @ObservedObject var Notes = NotesViewModel()
    @State var show = false
    @State var remove = false
    @State var txt = ""
    @State var noteID = ""
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            VStack{
                // MARK: - Status Bar
                HStack {
                    Text("Notes").font(.title).foregroundColor(.white).bold()
                    Spacer()
                    Button(action: {
                        remove.toggle()
                    }, label: {
                        Image(systemName: remove ? "xmark.circle" : "trash").resizable().frame(width: 25, height: 25).foregroundColor(.white)
                    })
                }.padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.blue)
                
                // MARK: - Displaying the Content
                if Notes.data.isEmpty {
                    if Notes.noData {
                        Spacer()
                        Text("")
                        Spacer()
                    } else {
                        Spacer()
                        Indicator()
                        Spacer()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack {
                            ForEach(Notes.data) { note in
                                HStack(){
                                    Button(action: {
                                        noteID = note.id
                                        txt = note.note
                                        show.toggle()
                                    }, label: {
                                        VStack {
                                            Text(note.note).font(.system(size: 35))
                                            Text(note.date).font(.footnote)
                                            Divider()
                                        }.padding().foregroundColor(.black)
                                    })
                                    if remove {
                                        Button(action: {
                                            
                                            deleteNote(noteId: note.id)
                                            
                                            //updating the note list
                                            Notes.fetchNotes()
                                        
                                        }, label: {
                                            Image(systemName: "minus.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(.red)
                                        })
                                    }
                                }.padding(.horizontal)
                            }
                        }
                    })
                }
                
            }.edgesIgnoringSafeArea(.top)
            
            // MARK: - 'Add' Button
            Button(action: {
                show.toggle()
                txt = ""
                noteID = ""
            }, label: {
                Image(systemName: "plus").resizable().frame(width: 25, height: 25).foregroundColor(.white)
            }).padding()
            .background(Color(.blue))
            .clipShape(Circle())
            .padding()
        }.sheet(isPresented: $show, onDismiss: Notes.fetchNotes, content: {
            EditView(txt: $txt, noteID: $noteID,show: $show)
        })
        .animation(.default)
    }
}

// MARK: - Delete the Note
func deleteNote(noteId: String) {
    let parameters: [String: String] = [
        "id" : "\(noteId)",
    ]
    
    AF.request(Constants.API, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
        
        switch response.result {
        
        case .failure(let error):
            print("Error deleting the note: \(error)")
            
        case .success(let value):
            print("Note deleted: \(value)")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
