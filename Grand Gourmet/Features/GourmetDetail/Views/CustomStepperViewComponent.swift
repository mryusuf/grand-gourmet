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
                
            }).buttonStyle(BorderlessButtonStyle())
            
            
            Text("\(value < 0 ? 0 : value)")
                .font(.system(size: 12, weight: .bold))
                .frame(width: 20)
            
            Button(action: {
                if self.value < maxValue {
                    self.value += 1
                    self.feedback()
                }
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color.gray)
                    .padding([.vertical], 4)
            }).buttonStyle(BorderlessButtonStyle())
        }
    }
    
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

