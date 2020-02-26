//
//  HostingController.swift
//  swift-ui-1
//
//  Created by Eric Dolecki on 2/20/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController <ContentView> {
    @objc override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
