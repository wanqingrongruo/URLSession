//: [Previous](@previous)

import Foundation

var str = "Hello, SessionTask"

let url = URL(string: "www.google.com")!

let dataTask = URLSession().dataTask(with: url)

let uploadTask = URLSession().uploadTask(with: URLRequest(url: url), from: nil) { (_, _, _) in
    //......
}

let downloadSession = URLSession()

let downloadTask = downloadSession.downloadTask(with: url)
var data: Data?

downloadTask.cancel { (resumeData) in
    // 保存
    data = resumeData
}

if let resumeData = data {
    downloadSession.downloadTask(withResumeData: resumeData)
}

// @available(iOS 9, *)
let streamTask = URLSession().streamTask(with: NetService(domain: "", type: "", name: ""))


//: [Next](@next)

