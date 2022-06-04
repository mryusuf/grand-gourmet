//
//  GourmetAddonItemViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 04/06/22.
//

import SwiftUI

struct GourmetAddonItemViewComponent: View {
    
    var name, addonPrice: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.caption)
            
            Spacer()
            
            Text("SGD \(addonPrice)")
                .font(.caption.bold())
            
        }
    }
}
