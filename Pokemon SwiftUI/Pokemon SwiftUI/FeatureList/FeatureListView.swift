//
//  FeatureListView.swift
//  Pokemon SwiftUI
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI
import DesignSystem
import PokemonListing
import PokemonTeam

struct FeatureListView: View {
    enum Action {
        case didTapOnListing
        case didTapOnTeam
    }
    
    var didTapOn: ((Action) -> Void)?
    var body: some View {
        ScrollView {
            VStack {
                PokemonListingFeatureViewRepresentable()
                    .frame(height: .cardMeasure)
                    .onTapGesture {
                        didTapOn?(.didTapOnListing)
                    }
                
                PokemonTeamFeatureViewRepresentable()
                    .frame(height: .cardMeasure)
                    .onTapGesture {
                        didTapOn?(.didTapOnTeam)
                    }
            }
        }
        .padding()
        .background(Color.BackgroundColors.backgroundColor)
        
    }
}

#Preview {
    FeatureListView()
}
