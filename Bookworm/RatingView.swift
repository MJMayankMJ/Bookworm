//
//  RatingView.swift
//  Bookworm
//
//  Created by Mayank Jangid on 10/22/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image (for numberd: Int) -> Image{
        if numberd > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
    var body: some View {
        HStack{
            if label.isEmpty {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button{
                    //if button is pressed the given star serial no. is the rating.....
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
                .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
                .accessibilityAddTraits(number > rating ? [] : [.isSelected])
            }
        }
        .buttonStyle(.plain)
        // without it in from in add boo view it taps every star one by one and this provents it.... it makes the tap are only limited to where u tap instead of whole form space in that area.... try without it to understand.....
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
                case .increment:
                    if rating < maximumRating { rating += 1 }
                case .decrement:
                    if rating > 1 { rating -= 1 }
                default:
                    break
                }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
