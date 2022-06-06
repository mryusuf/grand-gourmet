//
//  GourmetDetailView.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GourmetDetailView<ViewModel>: View where ViewModel: GourmetDetailViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    @State var selectedVariant = ""
    @State var quantity = 0
    @State var notes = ""
    @State var addonPrice: Double = 0
    
    private var totalPrice: Double {
        Double(quantity) * ((viewModel.gourmet?.displayPrice ?? 0) + addonPrice)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                content
            }
        }
        .onAppear {
            if viewModel.gourmet == nil {
                viewModel.fetchData()
            }
        }
    }
    
}

extension GourmetDetailView {
    
    var content: some View {
        VStack(alignment: .center) {
            
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 30, height: 3)
                .padding()
            
            ZStack(alignment: .bottom) {
                List {
                    // Image and Description Section
                    Section {
                        VStack(spacing: 15) {
                            WebImage(url: URL(string: viewModel.gourmet?.imageURL ?? ""))
                                .maxBufferSize(nil)
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(15)
                                .clipped()
                            
                            GourmetDescriptionViewComponent(
                                name: viewModel.gourmet?.name ?? "",
                                description: viewModel.gourmet?.gourmetDetailDescription ?? "",
                                tags: viewModel.gourmet?.tags ?? [],
                                isDiscount: viewModel.gourmet?.isDiscount ?? false,
                                displayPrice: viewModel.gourmet?.displayPrice.description  ?? "",
                                originalPrice: viewModel.gourmet?.price.description ?? ""
                            )
                            
                            Spacer()
                        }
                    }
                    
                    listSeparatorViewComponent
                    
                    // Variants Section
                    Section {
                        VStack(alignment: .leading) {
                            Text("Variants")
                                .bold()
                            
                            Menu {
                                Picker(selection: $selectedVariant, label: EmptyView()) {
                                    ForEach(viewModel.gourmet?.variants ?? [], id: \.self.name) { variant in
                                        Text(variant.name)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                
                            } label: {
                                dropdownLabel
                            }
                            
                            Spacer()
                        }
                    }
                    
                    listSeparatorViewComponent
                    
                    // Addon Section
                    // TODO: add Addon checkboxes and stepper
                    ForEach(viewModel.gourmet?.addons ?? [], id: \.self.addonCategoryID) { (addon: Addon) in
                        Section {
                            if let firstItem = addon.addonItems[0] {
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text(addon.addonCateogryName.capitalized)
                                        .bold()
                                    
                                    GourmetAddonItemViewComponent(
                                        name: firstItem.name,
                                        addonPrice: "\(firstItem.additionalPrice.description)"
                                    ) { (amount: Int) in
                                        print(amount)
                                        addonPrice += (Double(amount) * firstItem.additionalPrice)
                                    }
                                    
                                }
                                
                                ForEach(addon.addonItems, id:\.self.id) { (addonItem: AddonItem) in
                                    
                                    if addonItem.id != firstItem.id {
                                        
                                        GourmetAddonItemViewComponent(
                                            name: addonItem.name,
                                            addonPrice: "\(addonItem.additionalPrice.description)"
                                        ) { (amount: Int) in
                                            print(amount)
                                            addonPrice += (Double(amount) * firstItem.additionalPrice)
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                        listSeparatorViewComponent
                    }
                    
                    // NotesSection
                    Section {
                        notesSection
                    }
                }
                
                footerViewComponent
                    .padding()
            }
            .listStyle(.plain)
            .background(Color.white)
            .foregroundColor(Color.black)
        }
    }
    
    var dropdownLabel: some View {
        HStack {
            selectedVariant == "" ? Text("Choose One") : Text(String(selectedVariant))
            Spacer()
            Text("⌵")
                .offset(y: -4)
        }
        .font(.caption)
        .foregroundColor(Color.black)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
    var notesSection: some View {
        VStack(alignment: .leading) {
            Text("Notes")
                .bold()
            Text("Optional")
                .font(.footnote)
                .foregroundColor(Color.gray)
            
            TextField("E.g. no mushroom", text: $notes)
                .lineLimit(4)
            
            Divider()
            
            Spacer(minLength: 100)
        }
    }
    
    var footerViewComponent: some View {
        HStack {
            CustomStepperViewComponent(value: $quantity, maxValue: 25)
                .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                )
                .background(Color.white)
            
            Button(quantity == 0 ? "Add To Cart" : quantity > 0 ? "Add To Cart - SGD \(totalPrice.description)" : "Remove Item") {
                
            }
            .font(.caption.bold())
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 1)
            )
            .background(quantity == 0 ? Color.gray : quantity > 0 ? Color.blue : Color.red)
        }
    }
    
    var listSeparatorViewComponent: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .frame(height: 10)
            .padding([.horizontal], -20)
    }
}

struct GourmetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GourmetDetailMockViewModel()
        GourmetDetailView(viewModel: viewModel)
    }
}

final class GourmetDetailMockViewModel: GourmetDetailViewModelProtocol {
    @Published var gourmet: GourmetDetail? = nil
    @Published var isLoading: Bool = true
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.gourmet = GourmetDetail(
                id: "1",
                price: 3,
                displayPrice: 2,
                isDiscount: true,
                discountPercent: 30,
                imageURL: "https://i.picsum.photos/id/292/3852/2556.jpg?hmac=cPYEh0I48Xpek2DPFLxTBhlZnKVhQCJsbprR-Awl9lo",
                name: "Rosemary and bacon cupcakes",
                gourmetDetailDescription: "Crumbly cupcakes made with dried rosemary and back bacon",
                tags: [
                    "flour",
                    "butter",
                    "egg",
                    "sugar",
                    "rosemary",
                    "bacon"
                ],
                variants: [
                    Variant(id: "v1", name: "Mashed Potato"),
                    Variant(id: "v2", name: "French Fries")
                ],
                addons: [
                    Addon(
                        addonCategoryID: "sauce",
                        addonCateogryName: "sauce",
                        addonItems: [
                            AddonItem(id: "a1", name: "BBQ", additionalPrice: 0),
                            AddonItem(id: "a2", name: "Mushroom", additionalPrice: 0),
                        ]),
                    Addon(
                        addonCategoryID: "extra_side_dish_a",
                        addonCateogryName: "Extra Side Dish",
                        addonItems: [
                            AddonItem(id: "a1", name: "Cream Spinach", additionalPrice: 2),
                            AddonItem(id: "a2", name: "Mushroom", additionalPrice: 2),
                        ])
                ])
            
            self?.isLoading = false
        }
    }
}
