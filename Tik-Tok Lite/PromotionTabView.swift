import SwiftUI








struct PromotionTabView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var selectedTab = 0
    @State private var arrayView = [
        LayoutTabView(image: "promoStar", numberText: "Rate the app", instructionText: "Rate the app 5 stars and write a review in the AppStore", imageOffsetX: 20, imageScale: 0.7),
        LayoutTabView(image: "promoPhone", numberText: "Take a screenshot", instructionText: "Take a screenshot of the rating screen", imageOffsetX: 20, imageScale: 1),
        LayoutTabView(image: "promoLetter", numberText: "Send us a screenshot", instructionText: "In response, we will send you a promotional code that can be activated in Settings", imageOffsetX: 20, imageScale: 0.3),
        
    ]
    
    
    var body: some View {
        
        
        ZStack { // 1
            Color.black.ignoresSafeArea() // 2
            
            VStack {
                ZStack(){
                    Text("Month free")
                        .fontWeight(.black)
                        .foregroundColor(.roseColor)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            
                            closeTabView()
                            
                        } ){
                            
                            Image("CloseX")
                                .frame(width: 30, height: 30).background(Color.black)
                                .padding(.trailing, 28)
                            
                        }
                        .closeButtonStyle()
                        
                    }
                    
                }
                
                .padding(.top, 10)
             
                TabView(selection: $selectedTab) {
                    ForEach(0..<arrayView.count, id: \.self) { index in
                        arrayView[index]
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                .overlay(ThreeDotsIndexView(numberOfPages: arrayView.count, selectedTab: selectedTab), alignment: .bottom )
                .animation(.default)
                .padding(.bottom, 45)
                
                Button(action: {
                    
                    if selectedTab != 2{
                        
                        selectedTab += 1
                        
                    } else {
                        closeTabView()
                    }
                })  {
                    HStack{
                        Image("discount")
                        Text("Next")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                    }
                }
                .roseButtonStyle()
                // .buttonStyle(ActionButtonStyle())
                .padding(.bottom, 50)
                
                
                
                
            }
            
        }
        
        
    }
    
    func closeTabView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
    
}
    
    

