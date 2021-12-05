
import SwiftUI
import UIKit

//struct ContentView: View {
//    var body: some View {
//       Home()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct Home: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        
        VStack {
            
            Button{
                showSheet.toggle()
            } label: {
                Text("Present sheet")
            }
            .navigationTitle("Half modal")
            .halfSheet(showSheet: $showSheet){
                ZStack{
                // Half sheet view
                    Color.gray
                    VStack{
                Text("Half sheet view")
                        
                        Button{
                            showSheet.toggle()
                            
                        } label:{
                            
                            Text("Close from sheet")
                            }
                }
                }
                .ignoresSafeArea()
            } onEnd: {
               print("Dissmissed")
            }
        }
    }
    
}

// Custom half sheet modifier

extension View {
    
    // Binding show variable:
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () ->  SheetView, onEnd: @escaping () -> ()) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd))
    }
}

//UIKit integration

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
   
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: () -> ()
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if showSheet{
            
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
                
            } else {
                // closing view when showSheet toggled again
                uiViewController.dismiss(animated: true)
            }
        }
    
    
    // on dismiss
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate{
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper){
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd
        }
    }

}

//Custom UIHostingController

class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        // settings presentation controller properties
        if #available(iOS 15.0, *) {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents  = [
                    .medium(),
                    .large(),
                    
                    
                    
                ]
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
