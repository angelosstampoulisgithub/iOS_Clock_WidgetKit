//
//  WidgetClockLiveActivity.swift
//  WidgetClock
//
//  Created by Angelos Staboulis on 26/7/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetClockAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetClockLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetClockAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetClockAttributes {
    fileprivate static var preview: WidgetClockAttributes {
        WidgetClockAttributes(name: "World")
    }
}

extension WidgetClockAttributes.ContentState {
    fileprivate static var smiley: WidgetClockAttributes.ContentState {
        WidgetClockAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetClockAttributes.ContentState {
         WidgetClockAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetClockAttributes.preview) {
   WidgetClockLiveActivity()
} contentStates: {
    WidgetClockAttributes.ContentState.smiley
    WidgetClockAttributes.ContentState.starEyes
}
