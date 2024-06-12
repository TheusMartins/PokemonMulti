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
    var test: (() -> Void)?
    var body: some View {
        ScrollView {
            VStack {
                PokemonListingFeatureViewRepresentable()
                    .frame(height: .cardMeasure)
                    .onTapGesture {
                        test?()
                    }
                
                PokemonTeamFeatureViewRepresentable()
                    .frame(height: .cardMeasure)
                    .onTapGesture {
                        print("This is a test, pokemon team was tapped")
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
