//
//  Copyright (c) 2017 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Firebase
import MaterialComponents

class FPCommentCell: MDCCollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var moreButton: UIButton!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var dateLabel: UILabel!

  let attributes = [NSAttributedStringKey.font: UIFont.mdc_preferredFont(forMaterialTextStyle: .body2)]
  let attributes2 = [NSAttributedStringKey.font: UIFont.mdc_preferredFont(forMaterialTextStyle: .body1)]

  func populateContent(from: FPUser, text: String, date: Date, index: Int, isDryRun: Bool) {
    let attrText = NSMutableAttributedString(string: from.fullname , attributes: attributes)
    attrText.append(NSAttributedString(string: " " + text, attributes: attributes2))
    attrText.addAttribute(.paragraphStyle, value: FPCommentCell.paragraphStyle, range: NSMakeRange(0, attrText.length))
    label.attributedText = attrText
    label.accessibilityLabel = "\(from.fullname) said, \(text)"
    if let profilePictureURL = from.profilePictureURL, !isDryRun {
      UIImage.circleImage(with: profilePictureURL, to: imageView)
      imageView.accessibilityLabel = from.fullname
      imageView.accessibilityHint = "Double-tap to open profile."
    }
    imageView.tag = index
    label.tag = index
    dateLabel.text = date.timeAgo()
  }
}

extension FPCommentCell {
  static let paragraphStyle = { () -> NSMutableParagraphStyle in
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 2
    return style
  }()
}
