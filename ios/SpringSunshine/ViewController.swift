import UIKit

class ViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return false
    }

    private func degreesToRadians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180.0)
    }

    let colors: [UIColor] = [
        UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        UIColor(red: 0.000, green: 0.396, blue: 0.600, alpha: 1.00),
        UIColor(red: 0.000, green: 1.000, blue: 0.796, alpha: 1.00),
        UIColor(red: 0.600, green: 1.000, blue: 0.600, alpha: 1.00),
        UIColor(red: 0.600, green: 0.396, blue: 1.000, alpha: 1.00),
        UIColor(red: 0.600, green: 0.000, blue: 0.800, alpha: 1.00),
        UIColor(red: 1.000, green: 0.600, blue: 1.000, alpha: 1.00),
        UIColor(red: 1.000, green: 0.800, blue: 0.600, alpha: 1.00),
        UIColor(red: 1.000, green: 1.000, blue: 0.196, alpha: 1.00),
        UIColor(red: 0.396, green: 0.596, blue: 1.000, alpha: 1.00),
        UIColor(red: 1.000, green: 0.000, blue: 0.800, alpha: 1.00),
        UIColor(red: 1.000, green: 0.000, blue: 0.400, alpha: 1.00),
        UIColor(red: 0.400, green: 0.200, blue: 0.400, alpha: 1.00),
        UIColor(red: 0.600, green: 0.800, blue: 0.000, alpha: 1.00),
        ]

    var cv: UICollectionView!

    let size: CGFloat = 31

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: size, height: size)

        let frame = CGRect(x: 0, y: -size * 6, width: view.bounds.width, height: view.bounds.height + (size * 6 * 2))
        cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        view.addSubview(cv)

        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            if !self.cv.isDragging, !self.cv.isDecelerating {
                self.cv.contentOffset.y -= 0.6
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cv.contentOffset = CGPoint(x: 0, y: cv.contentSize.height / 2)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let count = UInt32(colors.count)
        let rnd = Int(arc4random_uniform(count))

        cell.isUserInteractionEnabled = false
        cell.layer.backgroundColor = colors[rnd].cgColor
//        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.opacity = 0.2
        cell.layer.cornerRadius = size / 2
//        cell.layer.borderColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
//        cell.layer.borderWidth = 0.5
//        cell.layer.shouldRasterize = true

        var transform = cell.layer.transform
        transform = CATransform3DScale(transform, 1, 1, 0)
        transform = CATransform3DRotate(transform, degreesToRadians(45), 0, 0, 1)
        cell.layer.transform = transform

        UIView.animate(withDuration: (Double(indexPath.row  % 5) + 1) * 7,
                       delay: Double(indexPath.row  % 7),
                       options: [.curveEaseInOut],
                       animations: {
                cell.layer.transform = CATransform3DMakeScale(3, 3, 0)
        }, completion: nil)

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

}
