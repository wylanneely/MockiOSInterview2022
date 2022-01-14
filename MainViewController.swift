import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - AppLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    // MARK: - Object Outlets
    @IBOutlet private var stampButtons: [UIButton]!
    @IBOutlet private var undoButton: UIBarButtonItem!
    @IBOutlet private var redoButton: UIBarButtonItem!
    
    // MARK: - Private Objects
    private var selectedColor: UIColor = .blue
    private var colorCount: [UIColor: Int] = [:]
    private var undoLabels: [UILabel] = []
    private var redoLabels: [UILabel] = []

}

// MARK: - Action Outlets
private extension MainViewController {
    
    @IBAction func stampTapped(_ sender: UIButton) {
        
        // Extract stamp color from the buttons background color.
        guard let stampColor = sender.backgroundColor else {
            return
        }
        // Update internal values.
        selectedColor = stampColor
        updateButtonColors(selectedButton: sender)
    }
    @IBAction func undoPressed(_ sender: UIBarButtonItem) {
        guard let lastLabel = undoLabels.popLast() else { return }
        if let labelColor = lastLabel.backgroundColor, let count = colorCount[labelColor] {
            colorCount[labelColor] = count - 1
        }
        lastLabel.removeFromSuperview()
        
       // updateUndoButtonState()
    }
}


// MARK: - Helper Methods
private extension MainViewController {
    func updateButtonColors(selectedButton: UIButton) {
        
        // Deselect all the color buttons.
        stampButtons.forEach { $0.alpha = 1.0 }
        
        // Select the relevant color button.
        selectedButton.alpha = 0.8
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        addSquare(with: selectedColor, at: sender.location(in: view))
    }
    
    //MARK: - *Create-R-U-D*
    
    func addSquare(with color: UIColor, at location: CGPoint) {
        
        //MARK: - Since UILabel conforms to 
       // let squareView = UIView(frame: CGRect(x: location.x, y: location.y, width: 50.0, height: 50.0))
        
        let squareLabelView = UILabel(frame: CGRect(x: location.x, y: location.y,
                                          width: 50.0, height: 50.0))
        squareLabelView.backgroundColor = selectedColor
        squareLabelView.textAlignment = .center
        squareLabelView.textColor = selectedColor.inverseColor() ?? .white
        
        if let existingColorCount = colorCount[selectedColor] {
            colorCount[selectedColor] = existingColorCount + 1
            squareLabelView.text = String(existingColorCount + 1)
        } else {
            squareLabelView.text = "1"
            colorCount[selectedColor] = 1
        }
        view.addSubview(squareLabelView)
        undoLabels.append(squareLabelView)
        updateUndoButtonState()
        updateRedoButtonState()
        view.addSubview(squareLabelView)
    }

        func updateUndoButtonState() {
        if undoLabels.isEmpty, undoButton.isEnabled {
            undoButton.isEnabled = false
        } else if !undoLabels.isEmpty, !undoButton.isEnabled {
            undoButton.isEnabled = true
        }
    }

    func updateRedoButtonState() {
        if redoLabels.isEmpty, redoButton.isEnabled {
            redoButton.isEnabled = false
        } else if !redoLabels.isEmpty, !redoButton.isEnabled {
            redoButton.isEnabled = true
        }
    }
//
}
 
