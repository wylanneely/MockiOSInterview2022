import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - AppLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    // MARK: - Object Outlets
    @IBOutlet private var stampButtons: [UIButton]!
    
    // MARK: - Private Objects
    private var selectedColor: UIColor = .blue
    
    
    
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
        let square = UIView(frame: CGRect(x: location.x, y: location.y,
                                          width: 50.0, height: 50.0))
        square.backgroundColor = selectedColor
        view.addSubview(square)
    }
    
}
