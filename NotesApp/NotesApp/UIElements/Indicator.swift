//
//  Indicator.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 23.03.2021.
//

import SwiftUI

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
    
}

struct Indicator_Previews: PreviewProvider {
    static var previews: some View {
        Indicator()
    }
}
