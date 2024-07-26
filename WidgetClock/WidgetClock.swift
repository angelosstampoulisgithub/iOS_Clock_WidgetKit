//
//  WidgetClock.swift
//  WidgetClock
//
//  Created by Angelos Staboulis on 26/7/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetClockEntryView : View {
    @State var date:DateComponents!

    var entry: Provider.Entry
    @State var hour:Double! = 0.0
    @State var minute:Double! = 0.0
    @State var dateString:String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.gray,.purple], startPoint: .top, endPoint: .bottom)
             VStack{
                 HStack{
                     Text("SwiftUI Clock").font(.caption).frame(width:90,height:45,alignment: .top).padding(15)
                 }
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
                 Spacer()
             }.frame(width:30,height:30)
            ZStack{
                VStack{
                    Image("face").resizable().frame(width: 90, height: 90, alignment: .center)
                }
                VStack{
                    Image("hand_hour").resizable().frame(width: 15, height: 90, alignment: .center).rotationEffect(Angle(degrees: hour! + 15))
                }
                VStack{
                    Image("hand_minute").resizable().frame(width: 15, height: 90, alignment: .center)
                        .rotationEffect(Angle(degrees: minute!))
                }
            }.frame(width:30,height:30)
            .onAppear(perform: {
                    date = Calendar.current.dateComponents(in: .current, from: Date())
                    hour = (360/12) * Double(date.hour!)
                    minute = (360/60) * Double(date.minute!)
            })
            VStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                HStack{
                    Text(dateString).font(.caption).frame(width:90,height:45,alignment: .bottom).padding(15)
                }.onAppear(perform: {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .none
                    dateFormatter.timeStyle = .short
                    dateString = dateFormatter.string(from: entry.date)
                })
               
            }.frame(width:30,height:30)
            
         }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct WidgetClock: Widget {
    let kind: String = "WidgetClock"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetClockEntryView(entry: entry, dateString: "")
                .containerBackground(.fill.quinary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        return intent
    }
}

#Preview(as: .systemSmall) {
    WidgetClock()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
