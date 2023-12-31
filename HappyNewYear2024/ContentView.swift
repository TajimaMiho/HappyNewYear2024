//
//  ContentView.swift
//  HappyNewYear2024
//
//  Created by 太島実穂 on 2023/12/31.
//

import SwiftUI

struct ContentView: View {
    @State private var countdown: String = ""
    @State private var isCountdownFinished: Bool = false
    
    var body: some View {
        VStack {
                  if isCountdownFinished {
                      Image("dragon")
                          .resizable()
                          .scaledToFill()
                          .frame(width: 250, height: 250)
                      Text("Happy New Year!!")
                          .padding()
                  } else {
                      Image("rabbit")
                          .resizable()
                          .scaledToFill()
                          .frame(width: 250, height: 250)
                      Text("2024年まであと \(countdown)")
                          .padding()
                          .onAppear(perform: startCountdown)
                  }
                  
              }
              .onChange(of: countdown) { newValue in
                  if newValue == "00:00:00" {
                      isCountdownFinished = true
                  }
              }
              .onChange(of: isCountdownFinished) { newValue in
                  if newValue {
                      Text("Happy New Year!")
                          .font(.largeTitle)
                          .padding()
                          .foregroundColor(.red)
                  }
              }
          }

    func startCountdown() {
        let calendar = Calendar.current
        // ターゲットの時刻設定
        let targetDateComponents = DateComponents(year: 2024, month: 1, day: 1)
        let targetDate = calendar.date(from: targetDateComponents)! // Date()に型を合わせる
        
        // カウントダウン（1秒ごとに発火）
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            // 現在時刻の取得
            let currenDate = Date()
            // 残り時間のコンポーネントを作成
            let components = calendar
                // 秒未満を切り捨て
                .dateComponents([.hour, .minute, .second],
                // 差分を計算
                from: currenDate, to: targetDate)
            // hour, minute, secondsがnilでないことを確認
            if let hours = components.hour, let minutes = components.minute, let seconds = components.second {
                //formatする
                countdown = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
        timer.tolerance = 0.1
        timer.fire()
    }
}

#Preview {
    ContentView()
}
