//
//  ViewController.swift
//  PdfViewer
//
//  Created by MCT on 8.05.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController, PDFViewDelegate {

    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image: UIImageView!
    
    var currentPage = 0
    var pdfDoc = PDFDocument()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if let path = Bundle.main.path(forResource: "pdf", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url:url) {
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
                captureThumbnail(pdfDocument: pdfDocument)
                pdfDoc = pdfDocument
            }
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentPageChanged),
                                               name: .PDFViewPageChanged, object:nil)
        
    }
    
    @objc func currentPageChanged(){
        currentPage = pdfDoc.index(for: pdfView.currentPage!)
        captureThumbnail(pdfDocument: pdfDoc)
        
    }
    
   
    
    func captureThumbnail(pdfDocument: PDFDocument) {
        if let page1 = pdfDocument.page(at:currentPage + 1) {
            image.contentMode = .scaleAspectFit
            image.image = page1.thumbnail(of: CGSize(width: image2.frame.size.width, height:image.frame.size.height), for: .artBox)
        }
        if let page2 = pdfDocument.page(at:currentPage + 2) {
            image2.contentMode = .scaleAspectFit
            image2.image = page2.thumbnail(of: CGSize(width: image2.frame.size.width, height:image2.frame.size.height), for: .artBox)
        }
        
    }
    
    
    
    
    
    

}

