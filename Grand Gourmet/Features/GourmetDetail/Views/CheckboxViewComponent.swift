//
//  CheckboxViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 06/06/22.
//

import SwiftUI

struct CheckboxViewComponent: View {
    @Binding var checked: Bool
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square" : "square")
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

