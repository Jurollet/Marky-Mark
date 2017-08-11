//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ImageViewLayoutBlockBuilder : LayoutBlockBuilder<UIView> {

    let	 markdownListener: MarkdownListener?

    init(markdownListener: MarkdownListener? = nil) {
        self.markdownListener = markdownListener
    }

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ImageBlockMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<UIView>, styling : ItemStyling) -> UIView {
        let imageBlockMarkDownItem = markDownItem as! ImageBlockMarkDownItem

        let imageView = RemoteImageView(file: imageBlockMarkDownItem.file, altText: imageBlockMarkDownItem.altText)

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onImageViewTapped(sender:))
        )
        tapGesture.numberOfTapsRequired = 1

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)

        let spacing:UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: imageView, spacing: spacing)
    }

    //MARK: - Actions

    @objc private func onImageViewTapped(sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? RemoteImageView else {
            return
        }
        markdownListener?.imageHasBeenSelected(file: imageView.file, altText: imageView.altText)
    }
}
