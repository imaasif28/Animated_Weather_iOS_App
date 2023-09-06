//
//  SegmentedControl.swift
//  Weather
//
//  Created by Aasif Malik on 04/09/23.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing :5){
            
            HStack{
                Button{
                    selection = 0
                } label: {
                    Text("Hourly Forecast")
                }.frame(minWidth: 0,maxWidth: .infinity)
                Button{
                    selection = 1
                } label: {
                    Text("Weekly Forecast")
                }.frame(minWidth: 0,maxWidth: .infinity)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.secondary)
            
            Divider()
                .background(.white.opacity(0.5))
                .blendMode(.overlay)
                .shadow(color: .black.opacity(0.2), radius: 0, x: 0, y: 1)
                .blendMode(.overlay)
                .overlay {
                    //MARK: Seperator
                    HStack {
                        Divider()
                            .background(Color.underline)
                            .frame(width: UIScreen.main.bounds.width / 2 , height: 3)
                            .blendMode(.overlay)
                        
                    }.frame(maxWidth: .infinity, alignment: selection == 0 ?.leading : .trailing)
                        .offset(y: -1)
                }

        }.padding(.top,25)
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl(selection: .constant(0))
    }
}
