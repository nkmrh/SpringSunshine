import UIKit
import PlaygroundSupport

class ViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        print(view.frame)

        view.backgroundColor = .black

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 32, height: 32)
        let frame = CGRect(x: 0, y: 0, width: 320, height: 640)
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        view.addSubview(cv)

        print(cv.contentSize)
        cv.contentOffset = CGPoint(x: 0, y: cv.contentSize.height / 2)

        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            if !cv.isDragging, !cv.isDecelerating {
                cv.contentOffset.y -= 0.26
            }
        }
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

        cell.layer.backgroundColor = colors[rnd].cgColor
        cell.layer.opacity = 0.2
        cell.layer.cornerRadius = 5
        guard let addFilter = CIFilter(name: "CIColorPosterize") else {
            fatalError("Could not create CIAdditionCompositing filter.")
        }
        cell.layer.backgroundFilters = [addFilter]

        var transform = cell.layer.transform
        transform = CATransform3DScale(transform, 1.4 * 2, 1.4 * 2, 0)
        transform = CATransform3DRotate(transform, degreesToRadians(45), 0, 0, 1)
        cell.layer.transform = transform

        UIView.animate(withDuration: 8,
                       delay: 0,
                       options: [
                        .autoreverse, .repeat, .curveEaseInOut
            ], animations: {
            cell.layer.transform = CATransform3DMakeScale(2, 2, 1)
        }, completion: nil)

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

}

PlaygroundPage.current.liveView = ViewController()
