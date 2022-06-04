//
//  CustomStepperViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 04/06/22.
//

import SwiftUI

struct CustomStepperViewComponent : View {
    @Binding var value: Int
    var maxValue: Int
    var footerPadding = EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
    
    var body: some View {
        HStack {
            
            Button(action: {
                if self.value > -1 {
                    self.value -= 1
                    self.feedback()
                }
            }, label: {
                Image(systemName: "minus")
                    .foregroundColor(Color.gray)
                    .padding([.vertical], 10)
                
            })
            
            
            Text("\(value < 0 ? 0 : value)")
                .font(.system(size: 12, weight: .bold))
            
            Button(action: {
                if self.value < maxValue {
                    self.value += 1
                    self.feedback()
                }
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color.gray)
            })
        }
        .padding(footerPadding)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

