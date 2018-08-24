//
//  positionView.swift
//  Euphoria
//
//  Created by 李政恩 on 16/08/2018.
//  Copyright © 2018 李政恩. All rights reserved.
//

import UIKit

class positionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentViewText: UILabel!
    @IBAction func contentViewButton(_ sender: Any) {
        contentViewText.text = "Get off work!"
    }
    
    //----------<Initialization of The xib File>----------
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    //----------------------------------------------------
    
    // Set the properties of this view
    private func commonInit() {
        Bundle.main.loadNibNamed("positionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


