//
//  ViewController.swift
//  NSOperationDemo
//
//  Created by ying on 16/4/8.
//  Copyright © 2016年 ying. All rights reserved.
//

//**********************************************************************************
//NSOperation 不需要关心线程管理和数据同步问题。NSOperation 是一个抽象类，必须派生出自己的子类
//使用NSOperation 两种方式：1、使用已定义好的NSBlockOperation；2、自定义子类
//**********************************************************************************

import UIKit

class ViewController: UIViewController {

    /*
     //使用NSOperation 1、使用已定义好的NSBlockOperation
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var operation = NSBlockOperation { 
            [weak self] in
            self?.downloadImage()
            return
        }
        
        //
        var queue = NSOperationQueue()
        queue.addOperation(operation)
    }
    
    func downloadImage() {
        var imageUrl = "http://hangge.com/blog/images/logo.png"
        var data = NSData(contentsOfURL: NSURL(string: imageUrl)!)
        print(data!.length)
    }
 */
    
    //使用NSOperation 2、自定义子类
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建线程对象
        var downloadImageOperation = DownloadImageOperation()
        //为operation定义回调
        var completionBlock: (() -> Void)?
        downloadImageOperation.completionBlock = completionBlock
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4), dispatch_get_main_queue()) {
            print("Complete")
        }
        
        //创建NSOperationQueue对象，并添加operation，这玩意，可以看作线程池
        var queue = NSOperationQueue()
        //设置线程池中的线程数目，也就是并发数
        //queue.maxConcurrentOperationCount = 5
        //取消所有线程
        //queue.cancelAllOperations()
        
        queue.addOperation(downloadImageOperation)
    }


}

class DownloadImageOperation: NSOperation {
    override func main() {
        var imageUrl = "http://hangge.com/blog/images/logo.png"
        var data = NSData(contentsOfURL: NSURL(string: imageUrl)!)
        print(data?.length)
    }
}

