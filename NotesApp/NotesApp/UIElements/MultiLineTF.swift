//
//  MultiLineTF.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 23.03.2021.
//

import Foundation
import SwiftUI

struct MultiLineTF: UIViewRepresentable {
    
    @Binding var txt: String
    
    // MARK: - TextView Setup
    func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> UITextView {
        let view = UITextView()
        if txt != "" {
            view.text = txt
            view.textColor = .black
        } else {
            view.text = "Type something"
            view.textColor = .gray
        }
        view.font = .systemFont(ofSize: 20)
        view.backgroundColor = .white
        view.isEditable = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
        
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return MultiLineTF.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTF
        
        init(parent1: MultiLineTF) {
            parent = parent1
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            if parent.txt == "" {
                textView.text = ""
                textView.textColor = .black
            }
    
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.txt = textView.text
        }
    }
}


