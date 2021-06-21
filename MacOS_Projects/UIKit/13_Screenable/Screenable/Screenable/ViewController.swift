//
//  ViewController.swift
//  Screenable
//
//  Created by tarrask on 21/06/2021.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    // Outlets
    @IBOutlet weak var dropShadowTarget: NSSegmentedControl!
    @IBOutlet weak var dropShadowStrength: NSSegmentedControl!
    @IBOutlet weak var backgroundColorEnd: NSColorWell!
    @IBOutlet weak var backgroundColorStart: NSColorWell!
    @IBOutlet weak var backgroundImage: NSPopUpButton!
    @IBOutlet weak var fontColor: NSColorWell!
    @IBOutlet weak var fontSize: NSPopUpButton!
    @IBOutlet weak var fontName: NSPopUpButton!
    @IBOutlet var caption: NSTextView!
    @IBOutlet weak var imageView: NSImageView!
    
    var screenshotImage: NSImage?
    
    var document: Document {
        let oughtToBeDocument = view.window?.windowController?.document as? Document
        assert(oughtToBeDocument != nil, "Unable to find the document for this view controller.")
        return oughtToBeDocument!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(importScreenshot))
        imageView.addGestureRecognizer(recognizer)
        
        loadFonts()
        loadBackgroundImages()
        
        generatePreview()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        updateUI()
        generatePreview()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func importScreenshot() {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["jpg", "png"]
        panel.begin { [unowned self] result in
            if result == .OK {
                guard let imageURL = panel.url else { return }
                screenshotImage = NSImage(contentsOf: imageURL)
                generatePreview()
            }
        }
    }
    
    @IBAction func export(_ sender: Any) {
        guard let image = imageView.image else { return }
        guard let tiffData = image.tiffRepresentation else { return }
        guard let imageRep = NSBitmapImageRep(data: tiffData) else { return }
        guard let png = imageRep.representation(using: .png, properties: [:]) else { return }
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["png"]
        panel.begin { result in
            if result == .OK {
                guard let url = panel.url else { return }
                do {
                    try png.write(to: url)
                } catch {
                    print (error.localizedDescription)
                }
            }
        }
    }
    
    func updateUI() {
        caption.string = document.screenshot.caption
        fontName.selectItem(withTitle: document.screenshot.captionFontName)
        fontSize.selectItem(withTag: document.screenshot.captionFontSize)
        fontColor.color = document.screenshot.captionColor
        if !document.screenshot.backgroundImage.isEmpty {
            backgroundImage.selectItem(withTitle: document.screenshot.backgroundImage)
        }
        backgroundColorStart.color = document.screenshot.backgroundColorStart
        backgroundColorEnd.color =
            document.screenshot.backgroundColorEnd
        dropShadowStrength.selectedSegment = document.screenshot.dropShadowStrength
        dropShadowTarget.selectedSegment = document.screenshot.dropShadowTarget
    }
        
    func generatePreview() {
        let image = NSImage(size: CGSize(width: 1242, height: 2208), flipped: false) { [unowned self] rect in
            guard let ctx = NSGraphicsContext.current?.cgContext else { return false }
            // our drawing code here
            clearBackground(context: ctx, rect: rect)
            drawBackgroundImage(rect: rect)
            drawColorOverlay(rect: rect)
            let captionOffset = drawCaption(context: ctx, rect: rect)
            drawDevice(context: ctx, rect: rect, captionOffset: captionOffset)
            drawScreenshot(context: ctx, rect: rect, captionOffset: captionOffset)
            
            return true
        }
        imageView.image = image
    }
    
    func drawScreenshot(context: CGContext, rect: CGRect, captionOffset: CGFloat) {
        guard let screenshot = screenshotImage else { return }
        screenshot.size = CGSize(width: 891, height: 1584)
        let offsetY = 314 - captionOffset
        screenshot.draw(at: CGPoint(x: 176, y: offsetY), from: .zero, operation: .sourceOver, fraction: 1)
    }
    
    func textDidChange(_ notification: Notification) {
        document.screenshot.caption = caption.string
        generatePreview()
    }
    
    func drawDevice(context: CGContext, rect: CGRect, captionOffset: CGFloat) {
        guard let image = NSImage(named: "iPhone") else { return }
        let offsetX = (rect.size.width - image.size.width) / 2
        var offsetY = (rect.size.height - image.size.height) / 2
        offsetY -= captionOffset
        
        if dropShadowStrength.selectedSegment != 0 {
            if dropShadowTarget.selectedSegment == 1 ||
                dropShadowTarget.selectedSegment == 2 {
                setShadow()
            }
        }
        
        image.draw(at: CGPoint(x: offsetX, y: offsetY), from: .zero, operation: .sourceOver, fraction: 1)
           if dropShadowStrength.selectedSegment == 2 {
              if dropShadowTarget.selectedSegment == 1 || dropShadowTarget.selectedSegment == 2 {
                 // create a stronger drop shadow by drawing again
                 image.draw(at: CGPoint(x: offsetX, y: offsetY), from: .zero, operation: .sourceOver, fraction: 1)
              }
        }
           // clear the shadow so it doesn't affect other stuff
           let noShadow = NSShadow()
           noShadow.set()
    }
    
    func drawCaption(context: CGContext, rect: CGRect) -> CGFloat {
        if dropShadowStrength.selectedSegment != 0 {
            // if the drop shadow is enabled
            if dropShadowTarget.selectedSegment == 0 ||
                dropShadowTarget.selectedSegment == 2 {
                // and is set to “Text” or “Both”
                setShadow()
            }
        }
        
        // pull out the string to render
        let string = caption.textStorage?.string ?? ""
        // inset the rendering rect to keep the text off the edges
        let insetRect = rect.insetBy(dx: 40, dy: 20)
        // combine the user's text with their attributes to create an attributed string
        let captionAttributes = createCaptionAttributes()
        let attributedString = NSAttributedString(string: string, attributes: captionAttributes)
        
        // draw the string in the inset rect
        attributedString.draw(in: insetRect)
        // if the shadow is set to "strong" then we'll draw the string again to make the shadow deeper
        if dropShadowStrength.selectedSegment == 2 {
            if dropShadowTarget.selectedSegment == 0 ||
                dropShadowTarget.selectedSegment == 2 {
                attributedString.draw(in: insetRect)
            }
        }
        // clear the shadow so it doesn't affect other stuff
        let noShadow = NSShadow()
        noShadow.set()
        // calculate how much space this attributed string needs
        let availableSpace = CGSize(width: insetRect.width, height: CGFloat.greatestFiniteMagnitude)
        let textFrame = attributedString.boundingRect(with: availableSpace, options: [.usesLineFragmentOrigin, .usesFontLeading])
        // send the height back to our caller
        return textFrame.height
    }
    
    func createCaptionAttributes() -> [NSAttributedString.Key: Any]? {
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        let fontSizes: [Int: CGFloat] = [0: 48, 1: 56, 2: 64, 3: 72, 4: 80, 5: 96, 6: 128]
        guard let baseFontSize = fontSizes[fontSize.selectedTag()]  else { return nil }
        let selectedFontName = fontName.selectedItem?.title.trimmingCharacters(in: .whitespacesAndNewlines) ?? "HelveticaNeue-Medium"
        guard let font = NSFont(name: selectedFontName, size: baseFontSize) else { return nil }
        let color = fontColor.color
        return [NSAttributedString.Key.paragraphStyle: ps,
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color]
    }
    
    func setShadow() {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize.zero
        shadow.shadowColor = NSColor.black
        shadow.shadowBlurRadius = 50
        // the shadow is now configured – activate it!
        shadow.set()
    }
    
    func clearBackground(context: CGContext, rect: CGRect) {
        context.setFillColor(NSColor.white.cgColor)
        context.fill(rect)
    }
    
    func drawBackgroundImage(rect: CGRect) {
        // if they chose no background image, bail out
        if backgroundImage.selectedTag() == 999 { return }
        // if we can't get the current title, bail out
        guard let title = backgroundImage.titleOfSelectedItem else { return }
        // if we can't convert that title to an image, bail out
        guard let image = NSImage(named: title) else { return }
        // still here? Draw the image!
        image.draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1)
    }
    
    func drawColorOverlay(rect: CGRect) {
        let gradient = NSGradient(starting: backgroundColorStart.color, ending: backgroundColorEnd.color)
        gradient?.draw(in: rect, angle: -90)
    }
    
    func loadFonts() {
        // find the list of fonts
        guard let fontFile = Bundle.main.url(forResource: "fonts", withExtension: nil) else { return }
        guard let fonts = try? String(contentsOf: fontFile) else { return }
        // split it up into an array by breaking on new lines
        let fontNames = fonts.components(separatedBy: "\n")
        // loop over every font
        for font in fontNames {
            if font.hasPrefix(" ") {
                // this is a font variation
                let item = NSMenuItem(title: font, action: #selector(changeFontName), keyEquivalent: "")
                item.target = self
                fontName.menu?.addItem(item)
            } else {
                // this is a font family
                let item = NSMenuItem(title: font, action: nil, keyEquivalent: "")
                item.target = self
                item.isEnabled = false
                fontName.menu?.addItem(item)
            }
        }
    }
    
    @objc func changeFontName() {
        setFontName(to: fontName.titleOfSelectedItem ?? "")
    }
    
    // NOTE: For project 15, I'll skip making this change to all the other methods in the app, because I just want to learn the stuff, not repeat it until I get bored.
    @objc func setFontName(to name: String) {
        // register the undo point with the current font name
           undoManager?.registerUndo(withTarget: self, selector: #selector(setFontName), object: document.screenshot.captionFontName)
        
        // update the font name
        document.screenshot.captionFontName = name
        
        // update the UI to match
           fontName.selectItem(withTitle: document.screenshot.captionFontName)
        
        // ensure the preview is updated
        generatePreview()
    }
    
    func loadBackgroundImages() {
        let allImages = ["Antique Wood", "Autumn Leaves", "Autumn Sunset", "Autumn by the Lake", "Beach and Palm Tree", "Blue Skies", "Bokeh (Blue)", "Bokeh (Golden)", "Bokeh (Green)", "Bokeh (Orange)", "Bokeh (Rainbow)", "Bokeh (White)", "Burning Fire", "Cherry Blossom", "Coffee Beans", "Cracked Earth", "Geometric Pattern 1", "Geometric Pattern 2", "Geometric Pattern 3", "Geometric Pattern 4", "Grass", "Halloween", "In the Forest", "Jute Pattern", "Polka Dots (Purple)", "Polka Dots (Teal)", "Red Bricks", "Red Hearts", "Red Rose", "Sandy Beach", "Sheet Music", "Snowy Mountain", "Spruce Tree Needles", "Summer Fruits", "Swimming Pool", "Tree Silhouette", "Tulip Field", "Vintage Floral", "Zebra Stripes"]
        for image in allImages {
            let item = NSMenuItem(title: image, action: #selector(changeBackgroundImage), keyEquivalent: "")
            item.target = self
            backgroundImage.menu?.addItem(item)
        }
    }
    
    // Actions
    @IBAction func changeFontSize(_ sender: NSMenuItem) {
        document.screenshot.captionFontSize = fontSize.selectedTag()
        generatePreview()
    }
    @IBAction func changeFontColor(_ sender: Any) {
        document.screenshot.captionColor = fontColor.color
        generatePreview()
    }
    @IBAction func changeBackgroundImage(_ sender: Any) {
        if backgroundImage.selectedTag() == 999 {
            document.screenshot.backgroundImage = ""
        } else {
            document.screenshot.backgroundImage =
                backgroundImage.titleOfSelectedItem ?? ""
        }
        generatePreview()
    }
    @IBAction func changeBackgroundColorStart(_ sender: Any) {
        document.screenshot.backgroundColorStart = backgroundColorStart.color
        generatePreview()
    }
    @IBAction func changeBackgroundColorEnd(_ sender: Any) {
        document.screenshot.backgroundColorEnd = backgroundColorEnd.color
        generatePreview()
    }
    @IBAction func changeDropShadowStrength(_ sender: Any) {
        document.screenshot.dropShadowStrength = dropShadowStrength.selectedSegment
        generatePreview()
    }
    @IBAction func changeDropShadowTarget(_ sender: Any) {
        document.screenshot.dropShadowTarget = dropShadowTarget.selectedSegment
           generatePreview()
    }
}

