//
//  Stylable.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import UIKit

enum Stylesheet {
  enum Button {}
}

protocol Styleable {}

extension UIView: Styleable {}

struct Style<View: Styleable> {

    private let style: (View) -> Void
    init(style: @escaping (View) -> Void) {
        self.style = style
    }

    @discardableResult
    func apply(to view: View) -> View {
        style(view)
        return view
    }
}

extension Styleable where Self: UIView {

    @discardableResult
    func apply<V>(_ style: Style<V>) -> V {
        guard let view = self as? V else {
            preconditionFailure("Unable to apply style for \(V.self) to \(type(of: self))")
        }
        style.apply(to: view)
        return view
    }
}
