//
//  Util.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import SwiftUI
import UIKit

extension NSObject {
    
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
    
    func printLog(_ msg: String) {
        print("[\(theClassName)] : \(msg)")
    }
    
}

protocol SwiftUICoordinator: AnyObject {}

struct TVLViewSwiftUI<Wrapper : UIView>: UIViewRepresentable {
    typealias SwiftUICoordinatorFactory = (() -> SwiftUICoordinator)
    typealias ViewFactory = (_ context: Context) -> Wrapper
    typealias Updater = ((Wrapper, Context) -> Void)
    
    var makeView: ViewFactory
    var coordinate: SwiftUICoordinatorFactory?
    var update: Updater?
    
    init(_ makeView: @escaping ViewFactory,
         updater update: Updater? = nil,
         coordinator coordinate: SwiftUICoordinatorFactory? = nil
    ) {
        print("TVLUISwiftUI: Init")
        self.makeView = makeView
        self.update = update
        self.coordinate = coordinate
    }

    func makeUIView(context: Context) -> Wrapper {
        print("TVLUIViewSwiftUI : makeUIView customtextfield")
        return makeView(context)
    }

    func updateUIView(_ view: Wrapper, context: Context) {
        print("TVLUIViewSwiftUI : updateUIView customtextfield")
        // allows rows to be compressed
//        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        // allows rows to be expanded
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        update?(view, context)
    }
    
    func makeCoordinator() -> SwiftUICoordinator? {
        print("TVLUIViewSwiftUI : makeCoordinator customtextfield")
        return coordinate?()
    }
    
    static func dismantleUIView(_ uiView: Wrapper, coordinator: SwiftUICoordinator?) {
        print("TVLUIViewSwiftUI : dismantle")
    }
}

struct TVLVCSwiftUI<Wrapper: UIViewController>: UIViewControllerRepresentable {
    typealias SwiftUICoordinatorFactory = (() -> SwiftUICoordinator)
    typealias VCFactory = (_ context: Context) -> Wrapper
    typealias Updater =  ((Wrapper, Context) -> Void)
    
    typealias UIViewControllerType = Wrapper
    
    var makeViewController: VCFactory
    var update: Updater?
    var coordinate: SwiftUICoordinatorFactory?
    
    init(_ makeVC: @escaping VCFactory,
         updater update: Updater? = nil,
         coordinator coordinate: SwiftUICoordinatorFactory? = nil
    ) {
        self.makeViewController = makeVC
        self.update = update
        self.coordinate = coordinate
    }
    
    func makeUIViewController(context: Context) -> Wrapper {
        makeViewController(context)
    }
    
    func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
        update?(uiViewController, context)
    }
    
    func makeCoordinator() -> SwiftUICoordinator? {
        return coordinate?()
    }
}
