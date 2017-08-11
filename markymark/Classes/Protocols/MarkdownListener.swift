//
//  MarkdownListener.swift
//  Pods
//
//  Created by Julien Rollet on 11/08/2017.
//
//

import Foundation

public protocol MarkdownListener {
    func imageHasBeenSelected(file: String, altText: String)
}
