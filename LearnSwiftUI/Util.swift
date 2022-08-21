//
//  Util.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import SwiftUI
import UIKit

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
        self.makeView = makeView
        self.update = update
        self.coordinate = coordinate
    }

    func makeUIView(context: Context) -> Wrapper {
        makeView(context)
    }

    func updateUIView(_ view: Wrapper, context: Context) {
        update?(view, context)
    }
    
    func makeCoordinator() -> SwiftUICoordinator? {
        return coordinate?()
    }
    
    static func dismantleUIView(_ uiView: Wrapper, coordinator: SwiftUICoordinator?) {
        coordinator?.onDismantle()
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
