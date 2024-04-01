import UIKit
import AVFoundation

extension MainViews {
    class ResultView: UIView {
        // MARK: - values
        let mapping: [Int: String] = [0: "А", 1: "Б", 2: "В", 3: "Г", 4: "Д", 
                                      5: "Е", 6: "Ж", 7: "З", 8: "И", 9: "К",
                                      10: "Л", 11: "М", 12: "Н", 13: "О", 14: "П", 
                                      15: "Р", 16: "С", 17: "Т", 18: "У", 19: "Ф",
                                      20: "Х", 21: "Ц", 22: "Ч", 23: "Ш", 24: "Ы", 
                                      25: "Ь", 26: "Э", 27: "Ю", 28: "Я"]

        // MARK: - Views
        private lazy var backgroundView: UIView = {
            let view = UIView()
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
            return view
        }()
        
        private lazy var resultLabel: UILabel = {
            let label = UILabel.defaultLabel(config: UILabel.Config(
                title: "",
                textColor: activeTheme.colors.blank,
                textAlignment: .center,
                font: activeTheme.fonts.resultLabel
            ))
            return label
        }()
        
        private lazy var backspaceResultButton: UIButton = {
            let button = UIButton()
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .default)
            let image = UIImage(systemName: "delete.backward", withConfiguration: imageConfig)
            button.setImage(image, for: .normal)
            button.tintColor = activeTheme.colors.blank
            button.addTarget(self, action: #selector(backspaceResultAction), for: .touchUpInside)
            return button
        }()
        
        private lazy var clearResultButton: UIButton = {
            let button = UIButton()
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .default)
            let image = UIImage(systemName: "xmark.square", withConfiguration: imageConfig)
            button.setImage(image, for: .normal)
            button.tintColor = activeTheme.colors.blank
            button.addTarget(self, action: #selector(clearResultAction), for: .touchUpInside)
            return button
        }()
        
        private lazy var addSpaceButton: UIButton = {
            let button = UIButton()
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .default)
            let image = UIImage(systemName: "dock.rectangle", withConfiguration: imageConfig)
            button.setImage(image, for: .normal)
            button.tintColor = activeTheme.colors.blank
            button.addTarget(self, action: #selector(addSpaceAction), for: .touchUpInside)
            return button
        }()

        // MARK: - Life Cycle
        init() {
            super.init(frame: .zero)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup
        private func setupViews() {
            backgroundColor = .clear
            setupBackgroundView()
            setupAddSpaceButton()
            setupClearResultButton()
            setupBackspaceResultButton()
            setupResultLabel()
        }
        
        private func setupBackgroundView() {
            addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        private func setupAddSpaceButton() {
            addSubview(addSpaceButton)
            addSpaceButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addSpaceButton.topAnchor.constraint(equalTo: self.topAnchor),
                addSpaceButton.widthAnchor.constraint(equalToConstant: 60),
                addSpaceButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
                addSpaceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        private func setupClearResultButton() {
            addSubview(clearResultButton)
            clearResultButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                clearResultButton.topAnchor.constraint(equalTo: self.topAnchor),
                clearResultButton.widthAnchor.constraint(equalToConstant: 60),
                clearResultButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                clearResultButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        private func setupBackspaceResultButton() {
            addSubview(backspaceResultButton)
            backspaceResultButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backspaceResultButton.topAnchor.constraint(equalTo: self.topAnchor),
                backspaceResultButton.widthAnchor.constraint(equalToConstant: 40),
                backspaceResultButton.trailingAnchor.constraint(equalTo: clearResultButton.leadingAnchor),
                backspaceResultButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        private func setupResultLabel() {
            addSubview(resultLabel)
            resultLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                resultLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                                 constant: 10),
                resultLabel.leadingAnchor.constraint(equalTo: addSpaceButton.trailingAnchor,
                                                     constant: 8),
                resultLabel.trailingAnchor.constraint(equalTo: backspaceResultButton.leadingAnchor,
                                                      constant: -8),
                resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                    constant: -10)
            ])
        }
        
        // MARK: - Actions
        @objc private func backspaceResultAction() {
            guard !(resultLabel.text?.isEmpty ?? true) else {
                return
            }
            resultLabel.text?.removeLast()
        }
        
        @objc private func clearResultAction() {
            resultLabel.text?.removeAll()
        }
        
        @objc func addSpaceAction() {
            resultLabel.text?.append(" ")
        }
        
        func updateResult(resultValue: String, confidence: Float) {

            let number = 3
            if let letter = mapping[number] {
                print(letter)
            }
            // swiftlint: disable all
            resultLabel.text?.append(self.mapping[Int(resultValue)!]!)
            // swiftlint: enable all
        }
    }
}
