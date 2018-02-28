//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import UIKit
import Foundation

// In order to create a mock UIApplication object for unit tests, we wrap
// the shared applciation into the `Application` struct. When testing, simply
// replace this object with a mock object conforming to the protocol below.

protocol UIApplicationProtocol {
    func canOpenURL(_ url: URL) -> Bool
}

extension UIApplication: UIApplicationProtocol {}

struct Application {
    static var shared: UIApplicationProtocol = UIApplication.shared
}
