//
//  SpalshScreenView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 10/04/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI


//var images: [UIImage]! = [UIImage(named: "JuicySequencia_00000")!,
//                          UIImage(named: "JuicySequencia_00020")!,
//                          UIImage(named: "JuicySequencia_00040")!,
//                          UIImage(named: "JuicySequencia_00060")!,
//                          UIImage(named: "JuicySequencia_00080")!,
//                          UIImage(named: "JuicySequencia_00100")!,
//
//]
//
//
//let animatedImage : UIImage! = UIImage.animatedImage(with: images, duration: 0.4)
//
//struct AnimatedImage: UIViewRepresentable {
//    func makeUIView(context: Self.Context) -> UIImageView {
//        return UIImageView(image: animatedImage)
//    }
//
//    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<AnimatedImage>) {
//    }
//}


struct ImageAnimated: UIViewRepresentable {
    let imageSize: CGSize
    let imageNames: [String]
    let duration: Double = 6.0
    
    func makeUIView(context: Self.Context) -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0
            , width: imageSize.width, height: imageSize.height))
        
        let animationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        animationImageView.clipsToBounds = true
        animationImageView.layer.cornerRadius = 5
        animationImageView.autoresizesSubviews = true
        animationImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        var images = [UIImage]()
        imageNames.forEach { imageName in
            if let img = UIImage(named: imageName) {
                images.append(img)
            }
        }
        
        animationImageView.image = UIImage.animatedImage(with: images, duration: duration)
        
        containerView.addSubview(animationImageView)
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ImageAnimated>) {
        
    }
}

struct SplashScreenView: View {
    static var shouldAnimate = true
    
    var body: some View {
        GeometryReader { geo in
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ImageAnimated(imageSize: CGSize(width: geo.size.height/2, height: geo.size.height/3), imageNames: ["JuicySequencia_00000",
                                                                                   "JuicySequencia_00001",
                                                                                   "JuicySequencia_00002",
                                                                                   "JuicySequencia_00003",
                                                                                   "JuicySequencia_00004",
                                                                                   "JuicySequencia_00005",
                                                                                   "JuicySequencia_00006",
                                                                                   "JuicySequencia_00007",
                                                                                   "JuicySequencia_00008",
                                                                                   "JuicySequencia_00009",
                                                                                   "JuicySequencia_00010",
                                                                                   "JuicySequencia_00011",
                                                                                   "JuicySequencia_00012",
                                                                                   "JuicySequencia_00013",
                                                                                   "JuicySequencia_00014",
                                                                                   "JuicySequencia_00015",
                                                                                   "JuicySequencia_00016",
                                                                                   "JuicySequencia_00017",
                                                                                   "JuicySequencia_00018",
                                                                                   "JuicySequencia_00019",
                                                                                   "JuicySequencia_00020",
                                                                                   "JuicySequencia_00021",
                                                                                   "JuicySequencia_00022",
                                                                                   "JuicySequencia_00023",
                                                                                   "JuicySequencia_00024",
                                                                                   "JuicySequencia_00025",
                                                                                   "JuicySequencia_00026",
                                                                                   "JuicySequencia_00027",
                                                                                   "JuicySequencia_00028",
                                                                                   "JuicySequencia_00029",
                                                                                   "JuicySequencia_00030",
                                                                                   "JuicySequencia_00031",
                                                                                   "JuicySequencia_00032",
                                                                                   "JuicySequencia_00033",
                                                                                   "JuicySequencia_00034",
                                                                                   "JuicySequencia_00035",
                                                                                   "JuicySequencia_00036",
                                                                                   "JuicySequencia_00037",
                                                                                   "JuicySequencia_00038",
                                                                                   "JuicySequencia_00039",
                                                                                   "JuicySequencia_00040",
                                                                                   "JuicySequencia_00041",
                                                                                   "JuicySequencia_00042",
                                                                                   "JuicySequencia_00043",
                                                                                   "JuicySequencia_00044",
                                                                                   "JuicySequencia_00045",
                                                                                   "JuicySequencia_00046",
                                                                                   "JuicySequencia_00047",
                                                                                   "JuicySequencia_00048",
                                                                                   "JuicySequencia_00049",
                                                                                   "JuicySequencia_00050",
                                                                                   "JuicySequencia_00050",
                                                                                   "JuicySequencia_00051",
                                                                                   "JuicySequencia_00052",
                                                                                   "JuicySequencia_00053",
                                                                                   "JuicySequencia_00054",
                                                                                   "JuicySequencia_00055",
                                                                                   "JuicySequencia_00056",
                                                                                   "JuicySequencia_00057",
                                                                                   "JuicySequencia_00058",
                                                                                   "JuicySequencia_00059",
                                                                                   "JuicySequencia_00060",
                                                                                   "JuicySequencia_00061",
                                                                                   "JuicySequencia_00062",
                                                                                   "JuicySequencia_00063",
                                                                                   "JuicySequencia_00064",
                                                                                   "JuicySequencia_00065",
                                                                                   "JuicySequencia_00066",
                                                                                   "JuicySequencia_00067",
                                                                                   "JuicySequencia_00068",
                                                                                   "JuicySequencia_00069",
                                                                                   "JuicySequencia_00070",
                                                                                   "JuicySequencia_00071",
                                                                                   "JuicySequencia_00072",
                                                                                   "JuicySequencia_00073",
                                                                                   "JuicySequencia_00074",
                                                                                   "JuicySequencia_00075",
                                                                                   "JuicySequencia_00076",
                                                                                   "JuicySequencia_00077",
                                                                                   "JuicySequencia_00078",
                                                                                   "JuicySequencia_00079",
                                                                                   "JuicySequencia_00080",
                                                                                   "JuicySequencia_00081",
                                                                                   "JuicySequencia_00082",
                                                                                   "JuicySequencia_00083",
                                                                                   "JuicySequencia_00084",
                                                                                   "JuicySequencia_00085",
                                                                                   "JuicySequencia_00086",
                                                                                   "JuicySequencia_00087",
                                                                                   "JuicySequencia_00088",
                                                                                   "JuicySequencia_00089",
                                                                                   "JuicySequencia_00090",
                                                                                   "JuicySequencia_00091",
                                                                                   "JuicySequencia_00092",
                                                                                   "JuicySequencia_00093",
                                                                                   "JuicySequencia_00094",
                                                                                   "JuicySequencia_00095",
                                                                                   "JuicySequencia_00096",
                                                                                   "JuicySequencia_00097",
                                                                                   "JuicySequencia_00098",
                                                                                   "JuicySequencia_00099",
                                                                                   "JuicySequencia_00100",
                                                                                   "JuicySequencia_00101",
                                                                                   "JuicySequencia_00102",
                                                                                   "JuicySequencia_00103",
                                                                                   "JuicySequencia_00104",
                                                                                   "JuicySequencia_00105",
                                                                                   "JuicySequencia_00106",
                                                                                   "JuicySequencia_00107",
                                                                                   "JuicySequencia_00108",
                                                                                   "JuicySequencia_00109",
                                                                                   "JuicySequencia_00110",
                                                                                   "JuicySequencia_00111",
                                                                                   "JuicySequencia_00112",
                                                                                   "JuicySequencia_00113",
                                                                                   "JuicySequencia_00114",
                                                                                   "JuicySequencia_00115",
                                                                                   "JuicySequencia_00116",
                                                                                   "JuicySequencia_00117",
                                                                                   "JuicySequencia_00118",
                                                                                   "JuicySequencia_00119",
                                                                                   "JuicySequencia_00120",
                                                                                   "JuicySequencia_00121",
                                                                                   "JuicySequencia_00122",
                                                                                   "JuicySequencia_00123",
                                                                                   "JuicySequencia_00124",
                                                                                   "JuicySequencia_00125",
                                                                                   "JuicySequencia_00126",
                                                                                   "JuicySequencia_00127",
                                                                                   "JuicySequencia_00128",
                                                                                   "JuicySequencia_00129",
                                                                                   "JuicySequencia_00130",
                                                                                   "JuicySequencia_00131",
                                                                                   "JuicySequencia_00132",
                                                                                   "JuicySequencia_00133",
                                                                                   "JuicySequencia_00134",
                                                                                   "JuicySequencia_00135",
                                                                                   "JuicySequencia_00136",
                                                                                   "JuicySequencia_00137",
                                                                                   "JuicySequencia_00138",
                                                                                   "JuicySequencia_00139",
                                                                                   "JuicySequencia_00140",
                                                                                   "JuicySequencia_00141",
                                                                                   "JuicySequencia_00142",
                                                                                   "JuicySequencia_00143",
                                                                                   "JuicySequencia_00144",
                                                                                   "JuicySequencia_00145",
                                                                                   "JuicySequencia_00146",
                                                                                   "JuicySequencia_00147",
                                                                                   "JuicySequencia_00148",
                                                                                   "JuicySequencia_00149",
                                                                                   "JuicySequencia_00150",
                                                                                   "JuicySequencia_00151",
                                                                                   "JuicySequencia_00152",
                                                                                   "JuicySequencia_00153",
                                                                                   "JuicySequencia_00154",
                                                                                   "JuicySequencia_00155",
                                                                                   "JuicySequencia_00156",
                                                                                   "JuicySequencia_00157",
                                                                                   "JuicySequencia_00158",
                                                                                   "JuicySequencia_00159",
                                                                                   "JuicySequencia_00160",
                                                                                   "JuicySequencia_00161",
                                                                                   "JuicySequencia_00162",
                                                                                   "JuicySequencia_00163",
                                                                                   "JuicySequencia_00164",
                                                                                   "JuicySequencia_00165",
                                                                                   "JuicySequencia_00166",
                                                                                   "JuicySequencia_00167",
                                                                                   "JuicySequencia_00168",
                                                                                   "JuicySequencia_00169",
                                                                                   "JuicySequencia_00170",
                                                                                   "JuicySequencia_00171",
                                                                                   "JuicySequencia_00172",
                                                                                   "JuicySequencia_00173",
                                                                                   "JuicySequencia_00174",
                                                                                   "JuicySequencia_00175",
                                                                                   "JuicySequencia_00176",
                                                                                   "JuicySequencia_00177",
                                                                                   "JuicySequencia_00178",
                                                                                   "JuicySequencia_00179",
                                                                                   "JuicySequencia_00180",
                                                                                   "JuicySequencia_00181",
                                                                                   "JuicySequencia_00182",
                                                                                   "JuicySequencia_00183",
                                                                                   "JuicySequencia_00184",
                                                                                   "JuicySequencia_00185",
                                                                                   "JuicySequencia_00186",
                                                                                   "JuicySequencia_00187",
                                                                                   "JuicySequencia_00188",
                                                                                   "JuicySequencia_00189",
                                                                                   "JuicySequencia_00190",
                                                                                   "JuicySequencia_00191",
                                                                                   "JuicySequencia_00192",
                                                                                   "JuicySequencia_00193",
                                                                                   "JuicySequencia_00194",
                                                                                   "JuicySequencia_00195",
                                                                                   "JuicySequencia_00196",
                                                                                   "JuicySequencia_00197",
                                                                                   "JuicySequencia_00198",
                                                                                   "JuicySequencia_00199",
                                                                                   "JuicySequencia_00200",
                                                                                   "JuicySequencia_00201",
                                                                                   "JuicySequencia_00202",
                                                                                   "JuicySequencia_00203",
                                                                                   "JuicySequencia_00204",
                                                                                   "JuicySequencia_00205",
                                                                                   "JuicySequencia_00206",
                                                                                   "JuicySequencia_00207",
                                                                                   "JuicySequencia_00208",
                                                                                   "JuicySequencia_00209",
                                                                                   "JuicySequencia_00200",
                                                                                   "JuicySequencia_00201",
                                                                                   "JuicySequencia_00202",
                                                                                   "JuicySequencia_00203",
                                                                                   "JuicySequencia_00204",
                                                                                   "JuicySequencia_00205",
                                                                                   "JuicySequencia_00206",
                                                                                   "JuicySequencia_00207",
                                                                                   "JuicySequencia_00208",
                                                                                   "JuicySequencia_00209",
                                                                                   "JuicySequencia_00200",
                                                                                   "JuicySequencia_00201",
                                                                                   "JuicySequencia_00202",
                                                                                   "JuicySequencia_00203",
                                                                                   "JuicySequencia_00204",
                                                                                   "JuicySequencia_00205",
                                                                                   "JuicySequencia_00206",
                                                                                   "JuicySequencia_00207",
                                                                                   "JuicySequencia_00208",
                                                                                   "JuicySequencia_00209"])
                
                .frame(width: geo.size.height/2, height: geo.size.height/3, alignment: .center)
            //        AnimatedImage()
            //
            //            .frame(width: 200)
        }
    }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
