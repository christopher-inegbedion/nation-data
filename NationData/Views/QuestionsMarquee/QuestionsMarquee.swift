//
//  QuestionsMarquee.swift
//  NationData
//
//  Created by Christopher Inegbedion on 24/08/2024.
//

import SwiftUI

struct QuestionsMarquee: View {
    var questions: [[String]] = [
        [
            "What is the inflation rate in Germany?",
            "What is the literacy rate in Japan?",
            "What is the GDP growth rate of Brazil?",
            "What is the population density in South Korea?",
            "What is the average life expectancy in France?"
        ],
        [
            "What is the unemployment rate in India?",
            "What is the inflation rate in the USA?",
            "What are the top export products of China?",
            "How many people live in Nigeria?",
            "What is the literacy rate in Argentina?"
        ],
        [
            "What is the corporate tax rate in the United States?",
            "What is the fertility rate in Italy?",
            "What is the percentage of renewable energy in Sweden?",
            "What is the average wage in the United Kingdom?"
        ],
        [
            "What is the carbon emission per capita in Saudi Arabia?",
            "What is the average household income in New Zealand?",
            "What is the unemployment rate in Spain?",
            "What is the urbanization rate in China?",
            "What is the inflation rate in Russia?"
        ],
        [
            "What is the carbon emission per capita in Saudi Arabia?",
            "What is the average household income in New Zealand?",
            "What are the top export products of China?",
            "What is the average life expectancy in France?",
            "What is the inflation rate in Germany?",
        ]
    ]
    var body: some View {
        VStack {
            ForEach(questions.indices) { i in
                HorizontalQuestionsMarquee(questions: questions[i])
            }
        }
    }
}

struct HorizontalQuestionsMarquee: View {
    @State private var offset: CGFloat = 0
    @State private var isScrollingLeft: Bool = Bool.random() // Randomly determine direction

    let interTextSpacing = 10.0
    
    var questions = [
        "What is the unemployment rate in India?",
        "What is the inflation rate in the USA?",
        "What are the top export products of China?",
        "How many people live in Nigeria?"
    ]
    
    var body: some View {
        
        GeometryReader { g in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: interTextSpacing) {
                    ForEach(questions, id: \.self) { question in
                        Question(text: question)
                    }
                }
                .background(
                    GeometryReader { contentGeo in
                        Color.clear
                            .onAppear {
                                startScrolling(width: contentGeo.size.width, parentWidth: g.size.width)
                            }
                    }
                )
                .offset(x: offset)
            }
        }
        .frame(height: 50) // Adjust the height of the marquee as needed
    }
    
    // Function to start the scrolling animation
    private func startScrolling(width: CGFloat, parentWidth: CGFloat) {
        let duration = Double(width / 30) // Adjust speed by changing the divisor
        
        
        if isScrollingLeft {
            // Scroll from right to left
            offset = parentWidth
            withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                offset = -width
            }
        } else {
            // Scroll from left to right
            offset = -width
            withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                offset = parentWidth
            }
        }
    }
}

private struct Question: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(UIColor.systemBlue))
            .cornerRadius(10)
    }
}

#Preview {
    QuestionsMarquee()
}
