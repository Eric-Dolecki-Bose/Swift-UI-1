//
//  ContentView.swift
//  swift-ui-1
//
//  Created by Eric Dolecki on 2/19/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import SwiftUI
import URLImage
import WXKDarkSky

// Acts like a component. Can define in it's own file, or whatever.
struct TopViewLeft: View
{
    var body: some View
    {
        HStack(alignment: .center)
        {
            Image(systemName: "hifispeaker.fill")
                .foregroundColor(.white)
                .font(.system(size: 32.0))
            
            Spacer()
            
            VStack
            {
                Text("SwiftUI")
                    .fontWeight(.black)
                    .foregroundColor(Color.white)
                Text("Layout")
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(hex: 0xCCCCCC))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.system(size: 9.0))
                .foregroundColor(Color(hex: 0xCCCCCC))
                .bold()
        }
    }
}








struct ContentView: View {
    
    // State variables are observed for changes.
    @State var currentDate = Date()
    @State var ampm = "**"
    @State var hideStatusBar = false
    @State var currentTempF = "--"
    @State var results = [Result]()
    @State var weatherIcon = "photo"
    @State var weatherSummary = "--"
    
    @State var image1 = "photo"
    @State var image2 = "photo"
    @State var image3 = "photo"
    @State var image4 = "photo"
    @State var image5 = "photo"
    @State var image6 = "photo"
    @State var image7 = "photo"
    @State var image8 = "photo"
    
    @State var day1 = "-"
    @State var day2 = "-"
    @State var day3 = "-"
    @State var day4 = "-"
    @State var day5 = "-"
    @State var day6 = "-"
    @State var day7 = "-"
    @State var day8 = "-"
    
    @State var progressValue: Float = 0.0
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        // The default cache for loaded images using URLImage is now one hour.
        
        URLImageService.shared.setDefaultExpiryTime(3600.0)
        
        // Clear it out for testing.
        
        URLImageService.shared.cleanFileCache()
    }
    
    var body: some View {
        
        // The background.
        ZStack {
            Color("MysteryGray")
            .edgesIgnoringSafeArea(.all)
                        
            ZStack(alignment: .bottomTrailing)
            {
                VStack
                {
                    TopViewLeft()
                    
                    List(results, id: \.trackId) { item in
                        
                        HStack {
                            
                            URLImage(URL(string: item.artworkUrl60)!,
                            delay: 0.25,
                            processors: [ Resize(size: CGSize(width: 60.0, height: 60.0), scale: UIScreen.main.scale) ],
                            
                            content:  {
                                $0.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:60, height:60)
                                    .clipped()
                            })
                            .frame(width: 60.0, height: 60.0)
                            .border(Color(hex: 0x444444), width: 1)
                            .shadow(color: .black, radius: 8)
                                .background(Color(hex:0x333333))
                            
                            VStack(alignment: .leading)
                            {
                                Text(item.trackName)
                                    .foregroundColor(Color(hex: 0xCCCCCC))
                                    .font(.headline)
                                    .truncationMode(.middle)
                                    .lineLimit(2)
                                                                
                                Text(item.collectionName)
                                    .foregroundColor(Color(hex: 0xAAAAAA))
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .truncationMode(.middle).lineLimit(1)
                            }
                        }
                    }
                    .frame(height: 220.0)
                    .onAppear(perform: loadData)
                    Spacer()
                }
                
                // Daily row of icons (8)
                ZStack {
                    HStack {
                        VStack {
                            Image(systemName: self.image1)
                                .foregroundColor(Color.orange)
                            Text(day1)
                                .foregroundColor(Color.orange)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image2)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day2)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image3)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day3)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image4)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day4)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image5)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day5)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image6)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day6)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image7)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day7)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        VStack {
                            Image(systemName: self.image8)
                                .foregroundColor(Color(hex: 0x888888))
                            Text(day8)
                                .foregroundColor(Color.gray)
                                .font(.caption)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }.frame(width: UIScreen.main.bounds.width / 9 - 6, height: 70)
                        
                        Spacer()
                    }
                }.padding(.bottom, 140)
                
                HStack {
                    Image(systemName: self.weatherIcon)
                        .foregroundColor(Color("SlimeGray"))
                        .font(.system(size: 48.0))
                        .padding(.leading, 20.0)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(currentTempF)°F")
                            .font(.largeTitle)
                            .foregroundColor(Color("SlimeGray"))
                            .padding(.trailing, 5)
                        Text("\(weatherSummary)")
                            .font(.footnote)
                            .foregroundColor(Color("SlimeGray"))
                            .padding(5)
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                         
      //NEW COMPONENT.
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 190)
                    .onAppear() {
                        var count: Float = -1.0
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                            count += 1
                            self.progressValue = count / 900 // 15 mins
                            if self.progressValue >= 1 {
                                count = -1.0
                                self.progressValue = 0
                            }
                        }
                    }
                
                Button("toggle status bar".uppercased()) {
                    withAnimation {
                        self.hideStatusBar.toggle()
                    }
                }
                .foregroundColor(.orange)
                .font(.footnote)
                
            }.padding()
            
            ZStack {
                VStack {
                    HStack {
                        Text("\(timeString(date: currentDate))")
                            .foregroundColor(.gray)
                            .font(.custom("HelveticaNeue-Light", size: 100.0))
                            .multilineTextAlignment(.center)
                            .onAppear(perform: {let _ = self.updateTimer}) //Kicks off the timer.
                            .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                        Text("\(ampmString(date: currentDate))")
                            .foregroundColor(.gray)
                            .font(.custom("HelveticaNeue", size: 40.0))
                            .padding(.leading, 6.0)
                            .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                    }
                    Text("\(greeting())")
                        .foregroundColor(Color("SlimeGray"))
                        .font(.system(size: 24.0))
                        .fontWeight(.light)
                        .kerning(1.5) // Spaces without pulling ligatures apart.
                }.onAppear {
                    self.loadWeatherData()
                    print("Weather will update in 900s (15min).")
                    let _ = self.updateTheWeather // Roll the timer.
                }
            }
        }
    .statusBar(hidden: hideStatusBar)
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm" //"hh:mm:ss a"
        return formatter
    }
    
    var ampmFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }
    
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    func ampmString(date: Date) -> String {
        let time = ampmFormatter.string(from: date)
        return time
    }
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.currentDate = Date()
        }
    }
    
    // Every 15 minutes fetch the weather. Limited to 1000 a day on this account.
    var updateTheWeather: Timer {
        Timer.scheduledTimer(withTimeInterval: 900, repeats: true) { (timer) in
            print("Scheduled loading of weather data.")
            self.loadWeatherData()
        }
    }
    
    func greeting() -> String
    {
        let midNight0       = Calendar.current.date(bySettingHour: 0, minute: 00, second: 00, of: currentDate)!
        let nightEnd        = Calendar.current.date(bySettingHour: 3, minute: 59, second: 59, of: currentDate)!
        let morningStart    = Calendar.current.date(bySettingHour: 4, minute: 00, second: 0, of: currentDate)!
        let morningEnd      = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: currentDate)!
        let noonStart       = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: currentDate)!
        let noonEnd         = Calendar.current.date(bySettingHour: 16, minute: 59, second: 59, of: currentDate)!
        let eveStart        = Calendar.current.date(bySettingHour: 17, minute: 00, second: 00, of: currentDate)!
        let eveEnd          = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: currentDate)!
        let nightStart      = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: currentDate)!
        let midNight24      = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: currentDate)!
        
        var greet = ""
        
        if ((currentDate >= midNight0) && (nightEnd >= currentDate)) {
             greet = "Good Night"
        } else if ((currentDate >= morningStart) && (morningEnd >= currentDate)) {
             greet = "Good Morning"
        } else if ((currentDate >= noonStart) && (noonEnd >= currentDate)) {
             greet = "Good Afternoon"
        } else if ((currentDate >= eveStart) && (eveEnd >= currentDate)) {
             greet = "Good Evening"
        } else if ((currentDate >= nightStart) && (midNight24 >= currentDate)) {
             greet = "Good Night"
        }
        
        return greet
    }
    
    // iTunes JSON data fetch.
    func loadData()
    {
        guard let url = URL(string: "https://itunes.apple.com/search?term=rush&entity=song&limit=75") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // Update UI on the main thread.
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results // Updates the UI.
                        print("Found \(self.results.count) Rush songs.")
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    // Hard-coded for Framingham and Eric's secret key. Using a WXKDarkSky helper. Makes things easier.
    func loadWeatherData()
    {
        print(#function)
        let secretKey   = "51464e930c997c43d1387086ea95d6f4"
        let latitude    = 42.281559
        let longitude   = -71.418831
        
        // https://github.com/WXKDarkSky/WXKDarkSky
        let request = DarkSkyRequest(key: secretKey)
        let point = DarkSkyRequest.Point(latitude: latitude, longitude: longitude)
        let options = DarkSkyRequest.Options()
        options.language = .english
        options.units = .imperial
        options.extendHourly = false
        options.exclude = [.alerts]
        
        if let url = request.buildURL(point: point, time: nil, options: options) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = DarkSkyResponse(data: data) {
                        if let temperature = response.currently?.temperature {
                            print("Current temperature is \(temperature)°F")
                            self.currentTempF = String(format: "%.0f", temperature)
                        }
                        if let summary = response.minutely?.summary {
                            print(summary)
                            self.weatherSummary = summary
                        }
                        if let icon = response.currently?.icon {
                            self.insertCorrectIcon(sValue: icon)
                        }
                            
                        var index = 1
                        for day in response.daily!.data {
                            //let strDate = day.time.toString(withFormat: "EEEE MMMM dd, yyyy")
                            let dayWeek = day.time.toString(withFormat: "EE").uppercased()
                            let hi = String(format: "%.0f", day.apparentTemperatureHigh!)
                            let lo = String(format: "%.0f", day.apparentTemperatureLow!)
                            let iconString = self.getCurrentIconConverted(sValue: day.icon!)

                            if index == 1 {
                                self.image1 = iconString
                                self.day1 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 2 {
                                self.image2 = iconString
                                self.day2 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 3 {
                                self.image3 = iconString
                                self.day3 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 4 {
                                self.image4 = iconString
                                self.day4 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 5 {
                                self.image5 = iconString
                                self.day5 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 6 {
                                self.image6 = iconString
                                self.day6 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 7 {
                                self.image7 = iconString
                                self.day7 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            } else if index == 8 {
                                self.image8 = iconString
                                self.day8 = "\(dayWeek)\n\(hi)°\n\(lo)°"
                            }
                            //print("\(index). \(dayWeek) \(strDate): high: \(high)°F, low: \(low)°F, icon: \(iconString)")
                            index = index + 1
                        }
                    }
                } else {
                    print("Weather fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
    
    // Sets the icon, because it's a state variable, updates the UI.
    func insertCorrectIcon(sValue: String) {
        if sValue == "clear-day" {
            self.weatherIcon = "sun.max"
        } else if sValue == "clear-night" {
            self.weatherIcon = "moon"
        } else if sValue == "rain" {
            self.weatherIcon = "cloud.rain"
        } else if sValue == "snow" {
            self.weatherIcon = "cloud.snow"
        } else if sValue == "sleet" {
            self.weatherIcon = "cloud.sleet"
        } else if sValue == "wind" {
            self.weatherIcon = "wind"
        } else if sValue == "fog" {
            self.weatherIcon = "cloud.fog"
        } else if sValue == "cloudy" {
            self.weatherIcon = "cloud"
        } else if sValue == "partly-cloudy-day" {
            self.weatherIcon = "cloud.sun"
        } else if sValue == "partly-cloudy-night" {
            self.weatherIcon = "cloud.moon"
        } else if sValue == "hail" {
            self.weatherIcon = "cloud.hail"
        } else if sValue == "thunderstorm" {
            self.weatherIcon = "cloud.bolt.rain"
        } else if sValue == "tornado" {
            self.weatherIcon = "tornado"
        } else {
            self.weatherIcon = "sparkles"
        }
    }
    
    func getCurrentIconConverted(sValue: String) -> String {
        if sValue == "clear-day" {
            return "sun.max"
        } else if sValue == "clear-night" {
            return "moon"
        } else if sValue == "rain" {
            return "cloud.rain"
        } else if sValue == "snow" {
            return "cloud.snow"
        } else if sValue == "sleet" {
            return "cloud.sleet"
        } else if sValue == "wind" {
            return "wind"
        } else if sValue == "fog" {
            return "cloud.fog"
        } else if sValue == "cloudy" {
            return "cloud"
        } else if sValue == "partly-cloudy-day" {
            return "cloud.sun"
        } else if sValue == "partly-cloudy-night" {
            return "cloud.moon"
        } else if sValue == "hail" {
            return "cloud.hail"
        } else if sValue == "thunderstorm" {
            return "cloud.bolt.rain"
        } else if sValue == "tornado" {
            return "tornado"
        } else {
            return "sparkles"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Sample fetching code.

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artworkUrl60: String
}
