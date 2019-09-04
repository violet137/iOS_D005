//
//===----------------------------------------------------------------------===//
//
//  UIView+Layout.swift
//
//  Created by Steven Grosmark on 11/23/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2018 WW International, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//===----------------------------------------------------------------------===//
//

import UIKit

extension UIView {
    
    /// Access to auto layout constrains for the view
    public var layout: Layout { return Layout(self) }
    
    /// Access to auto layout constraints for the view, at a specific priority.
    /// All constraints set up based on this Layout instance will be at the specified priority.
    public func layout(priority: LayoutPriority) -> Layout {
        return Layout(self, priority: priority)
    }
    
}
