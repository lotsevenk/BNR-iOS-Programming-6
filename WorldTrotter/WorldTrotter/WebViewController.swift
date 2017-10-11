//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by AmeriHealth Caritas Employee on 10/6/17.
//  Copyright © 2017 Tin Pan Tech. All rights reserved.
//

import UIKit
import WebKit

 class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.bignerdranch.com/")
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared

            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async(execute: {
                        self.webView.load(request)
                    })
                } else {
                    print("ERROR: |(error)")
                }
            }
            task.resume()
        }
    }
}
