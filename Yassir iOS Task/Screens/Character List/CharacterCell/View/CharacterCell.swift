//
//  CharacterCell.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCell: View {

    private let character: CartoonCharacter
    private let viewModel: CharacterCellViewModel
    private let cellCornerRadius: CGFloat = 16

    init(character: CartoonCharacter) {
        self.character = character
        viewModel = CharacterCellViewModel(status: character.status)
    }

    var body: some View {
        HStack {
            WebImage(url: URL(string: character.image))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Spacer()
                Text(character.name)
                    .font(.system(size: 18, weight: .bold))
                Text(character.species)
                    .foregroundColor(.gray)
                    .font(.callout)
                Spacer()
                Spacer()
            }
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: cellCornerRadius)
                .stroke(
                    Color.gray.opacity(0.3),
                    lineWidth: viewModel.styler.hasBorder ? 0.5 : 0))
        .background(viewModel.styler.backgroundColor.cornerRadius(cellCornerRadius))
        .padding(.horizontal)
        .padding(.bottom, 16)
        .frame(height: 130)
    }
}

#Preview {
    CharacterCell(character: CartoonCharacter.previewCharacter)
}
