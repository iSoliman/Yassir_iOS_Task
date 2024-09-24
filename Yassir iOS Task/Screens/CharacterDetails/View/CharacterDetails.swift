//
//  CharacterDetails.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetails: View {

    private let character: CartoonCharacter
    private let screenWidth = UIScreen.main.bounds.width
    private let backAction: () -> ()

    init(character: CartoonCharacter, backAction: @escaping () -> ()) {
        self.character = character
        self.backAction = backAction
    }

    var body: some View {
        VStack {
            imagePart
                .padding(.bottom, 16)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(character.name)
                        .font(.title.bold())
                    Spacer()
                    Text(character.status)
                        .font(.callout)
                        .padding(.horizontal, 12)
                        .frame(height: 34)
                        .background(
                            Color(
                                red: 95/255,
                                green: 204/255,
                                blue: 244/255)
                            .cornerRadius(17))
                }
                HStack {
                    Text("Elf .")
                        .font(.callout)
                    Text(character.gender)
                        .font(.callout)
                        .foregroundColor(.gray.opacity(0.8))
                }
                .padding(.bottom, 16)
                HStack {
                    Text("Locations:")
                        .font(.callout)
                    Text(character.location.name)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .ignoresSafeArea()
    }

    private var imagePart: some View {
        ZStack(alignment: .topLeading) {
            WebImage(url: URL(string: character.image))
                .resizable()
                .scaledToFill()
                .frame(height: screenWidth)
                .cornerRadius(32)
            Button(action: backAction, label: {
                Image(systemName: "arrow.backward")
            })
            .foregroundColor(.black)
            .frame(width: 40, height: 40)
            .background(Circle().fill(Color.white))
            .padding(.leading, 32)
            .padding(.top, 64)
        }
    }
}

#Preview {
    CharacterDetails(
        character: CartoonCharacter.previewCharacter,
        backAction: {})
}
