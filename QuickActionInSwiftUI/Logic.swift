//
//  Logic.swift
//  QuickActionInSwiftUI
//
//  Created by ramil on 04.01.2021.
//

import Foundation
import SwiftUI

struct QuickAction: Hashable {
    var type: String
    var title: String
    var subtitle: String
    var icon: String
    
    func quickAction() -> UIApplicationShortcutItem {
        return UIApplicationShortcutItem(type: self.type, localizedTitle: self.title, localizedSubtitle: self.subtitle, icon: .init(systemImageName: self.icon), userInfo: ["type" : self.type as NSSecureCoding])
    }
}

enum ActionType: CaseIterable {
    case DynamicOne
    case DynamicTwo
    case DynamicThree
    case StaticOne
    case StaticTwo
    
    var instance: QuickAction {
        switch self {
        case .DynamicOne:
            return QuickAction(type: "Dynamic 1", title: "First Dynamic", subtitle: "This is first dynamic action", icon: "1.circle")
        case .DynamicTwo:
            return QuickAction(type: "Dynamic 2", title: "Second Dynamic", subtitle: "This is second dynamic", icon: "2.circle")
        case .DynamicThree:
            return QuickAction(type: "Dynamic 3", title: "Third Dynamic", subtitle: "This is third dynamic", icon: "3.circle")
        case .StaticOne:
            return QuickAction(type: "Static 1", title: "First Static", subtitle: "This is first static", icon: "1.cicle")
        case .StaticTwo:
            return QuickAction(type: "Static 2", title: "Second Static", subtitle: "This is second static", icon: "2.circle")
        }
    }
}

let allDynamicActions: [QuickAction] = [
    ActionType.DynamicOne.instance,
    ActionType.DynamicTwo.instance,
    ActionType.DynamicThree.instance,
]

func getAction(_ typeString: String) -> QuickAction? {
    if let action = ActionType.allCases.first(where: {$0.instance.type == typeString}) {
        return action.instance
    } else {
        return nil
    }
}

class QuickActionObservable: ObservableObject {
    @Published var selectedAction: QuickAction? = nil
}
