//
//  ContentView.swift
//  CJWRules
//
//  Created by Adewale Folorunsho on 3/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentSlide = 0
    var body: some View {
		ZStack{
			Color.white
				.edgesIgnoringSafeArea(.all)
        	VStack {
				switch currentSlide{
				case 0:
					TimerView()
				case 1:
                    SmoothLoveNoteView()
				case 2:
					Final()
				default:
					TimerView()
				}
				
				HStack(spacing: 8) {
					ForEach(0..<3, id: \.self) { index in
						Circle()
							.fill(currentSlide == index ? Color.purple : Color.gray)
							.frame(width: 8, height: 8)
					}
				}
				.padding(.top, 20)
			}
			.padding()
			.gesture(
				DragGesture(minimumDistance: 50)
					.onEnded{ gesture in
						if gesture.translation.width > 0 {
							withAnimation{
								currentSlide = max(0, currentSlide - 1 )
							}
						}else if gesture.translation.width < 0 {
							withAnimation{
								currentSlide = min(2, currentSlide + 1 )
							}
						}
					}
			)
        }
		
    }
}

#Preview {
    ContentView()
}
