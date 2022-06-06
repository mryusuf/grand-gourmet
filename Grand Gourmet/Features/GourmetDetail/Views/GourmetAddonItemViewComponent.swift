//
//  GourmetAddonItemViewComponent.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 04/06/22.
//

import SwiftUI

struct GourmetAddonItemViewComponent: View {
    
    var name, addonPrice: String
    var amountIsChangeCompletion: (_ amount: Int) -> Void
    
    @State private var isCheck = false {
        didSet {
            if isCheck {
                amount += 1
            } else {
                amount = 0
            }
        }
    }
    @State private var amount: Int = 0 {
        didSet {
            amountIsChangeCompletion(self.amount)
        }
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(.caption)
            
            Spacer()
            
            if isCheck {
                CustomStepperViewComponent(value: $amount, maxValue: 25)
                    .onChange(of: self.amount) { [amount] (changedAmount: Int) in
                        let changes = changedAmount == -1 ? 0 : amount > changedAmount ? -1 : 1
                        amountIsChangeCompletion(changes)
                    }
            }
            
            Text("SGD \(addonPrice)")
                .font(.caption.bold())
            
            CheckboxViewComponent(checked: $isCheck)
            
        }
    }
}
