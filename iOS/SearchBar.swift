//
//  SearchBar.swift
//  SpaceX
//
//  Created by Giulio Russo on 23/09/20.
//

import SwiftUI

// Thanks @Geri-Borbas <3

class SearchBar: NSObject, ObservableObject {
  var placeholder = "Search"

  @Published var text = ""
  let searchController = UISearchController(searchResultsController: nil)

  override init() {
    super.init()
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchResultsUpdater = self

    searchController.searchBar.placeholder = placeholder
  }
}

extension SearchBar: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text {
      self.text = text
    }
  }
}

// MARK: -

final class ViewControllerResolver: UIViewControllerRepresentable {
  let onResolve: (UIViewController) -> Void

  init(onResolve: @escaping (UIViewController) -> Void) {
    self.onResolve = onResolve
  }

  func makeUIViewController(context _: Context) -> ParentResolverViewController {
    ParentResolverViewController(onResolve: onResolve)
  }

  func updateUIViewController(_: ParentResolverViewController, context _: Context) {}
}

class ParentResolverViewController: UIViewController {
  let onResolve: (UIViewController) -> Void

  init(onResolve: @escaping (UIViewController) -> Void) {
    self.onResolve = onResolve
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
  }

  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)

    if let parent = parent {
      onResolve(parent)
    }
  }
}

// MARK: -

struct SearchBarModifier: ViewModifier {
  let searchBar: SearchBar

  func body(content: Content) -> some View {
    content.overlay(
      ViewControllerResolver { viewController in
        viewController.navigationItem.searchController = self.searchBar.searchController
      }.frame(width: 0, height: 0)
    )
  }
}

extension View {
  func add(_ searchBar: SearchBar) -> some View {
    modifier(SearchBarModifier(searchBar: searchBar))
  }
}

// MARK: -

extension UIApplication {
  func endEditing(_ force: Bool) {
    windows
      .filter(\.isKeyWindow)
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged { _ in
    UIApplication.shared.endEditing(true)
  }

  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    modifier(ResignKeyboardOnDragGesture())
  }
}
