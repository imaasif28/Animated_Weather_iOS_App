//
//  HomeView.swift
//  Weather
//
//  Created by Aasif Malik on 11/02/23.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable{
    case top = 0.83 // 782/844 from design
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    var bottomSheetTranslationPtorated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let scnHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = scnHeight + 36
                ZStack{
                    Color.background
                        .ignoresSafeArea()
                    //MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationPtorated * imageOffset)
                    Image("House")
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,257)
                        .offset(y: -bottomSheetTranslationPtorated * imageOffset)
                    //MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationPtorated )){
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack{
                            Text(attributedString)
                        }
                        Spacer()
                    }.padding(.top,51)
                        .offset(y: -bottomSheetTranslationPtorated * 46)
                    
                    //MARK: Bottom Sheet
                    
                    BottomSheetView(position:$bottomSheetPosition) {
//                        Text(bottomSheetTranslationPtorated.formatted())
                    } content: {
                        ForecastView()
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / scnHeight
                    }

                    //MARK: Tab bar
                    TabBar(action:{
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationPtorated * 115)
                    
                }
            }
        }                .navigationBarHidden(true)
    }
}

private var attributedString :AttributedString{
    var str = AttributedString("19°"+"\n "+"Mostly Clear")
    if let temp = str.range(of: "19°"){
        str[temp].font = .system(size: 96, weight: .thin)
        str[temp].foregroundColor = .primary
    }
    if let pipe = str.range(of: " | "){
        str[pipe].font = .title3.weight(.semibold)
        str[pipe].foregroundColor = .secondary
    }
     if let weather = str.range(of: " Mostly Clear"){
        str[weather].font = .title3.weight(.semibold)
        str[weather].foregroundColor = .secondary
    }
    return str
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
