import UIKit
import SnapKit
extension UIView{
    func fillSuperView(superView view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)){
        view.addSubview(self)
        self.snp.makeConstraints { (mk) in
            mk.edges.equalTo(view).inset(padding)
        }
    }
    func constraintWidth(_ width: CGFloat) {
        self.snp.makeConstraints { (mk) in
            mk.width.equalTo(width)
        }
    }
    func constraintHeight(_ height: CGFloat) {
        self.snp.makeConstraints { (mk) in
            mk.height.equalTo(height)
        }
    }
}

