//
//  AppTheme.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import SwiftUI

extension Color {
  struct AppTheme {
      static var yellow = Color(red: 255/255.0, green: 230.0/255.0, blue: 164.0/255.0)
      static var green = Color(red: 203.0/255.0, green: 255.0/255.0, blue: 219.0/255.0)
      static var purple = Color(red: 180.0/255.0, green: 158.0/255.0, blue: 255.0/255.0)
      static var red = Color(red: 255.0/255.0, green: 172.0/255.0, blue: 172.0/255.0)
      static var blue = Color(red: 161.0/255.0, green: 254.0/255.0, blue: 255.0/255.0)
      
      static var themeColors = [purple, blue, green, yellow, red]
      
      static var background = Color(red: 2.0/255.0, green: 11.0/255.0, blue: 37.0/255.0)
      static var primary = Color(red: 41.0/255.0, green: 0.0/255.0, blue: 70.0/255.0)
  }
}
