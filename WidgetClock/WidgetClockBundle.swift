//
//  WidgetClockBundle.swift
//  WidgetClock
//
//  Created by Angelos Staboulis on 26/7/24.
//

import WidgetKit
import SwiftUI

@main
struct WidgetClockBundle: WidgetBundle {
    var body: some Widget {
        WidgetClock()
        WidgetClockLiveActivity()
    }
}
