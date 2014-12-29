import Foundation
import UIKit
import CoreMedia

class TMAnalyzer{
    var matcher: TemplateMatcher
    var paiTypes: [Pai]
    
    init() {
        self.matcher = TemplateMatcher()
        self.paiTypes = [Pai]()
        self.setupPaiTypes()
    }
    
    func setupPaiTypes() {
        
        let keys = [
            "m1t", "m2t", "m3t", "m4t", "m5t", "m6t", "m7t", "m8t", "m9t",
            "p1t", "p2t", "p3t", "p4t", "p5t", "p6t", "p7t", "p8t", "p9t",
            "s1t", "s2t", "s3t", "s4t", "s5t", "s6t", "s7t", "s8t", "s9t",
            "j1t", "j2t", "j3t", "j4t", "j5t", "j6t", "j7t",
            "m1l", "m2r", "m3l", "m4l", "m5l", "m6l", "m7l", "m8l", "m9l",
            "p1l", "p2l", "p3l", "p4l", "p5l", "p6l", "p7l", "p8l", "p9l",
            "s1l", "s2l", "s3l", "s4l", "s5l", "s6l", "s7l", "s8l", "s9l",
            "j1l", "j2l", "j3l", "j4l", "j5l", "j6l", "j7l",
            "m1r", "m2r", "m3r", "m4r", "m5r", "m6r", "m7r", "m8r", "m9r",
            "p6r", "p7r",
            "s1r", "s3r", "s7r",
            "j1r", "j2r", "j3r", "j4r", "j6r", "j7r",
            "m1b", "m2b", "m3b", "m4b", "m5b", "m6b", "m7b", "m8b", "m9b",
            "p6b", "p7b",
            "s1b", "s3b", "s7b",
            "j1b", "j2b", "j3b", "j4b", "j6b", "j7b"
        ]
//        let keys = ["j1t", "s6t"]
        
        for key in keys {
            paiTypes.append(Pai.parse(key)!)
        }
    }
    
    // @uiimage トリミングされた画像
    func analyze(uiimage : UIImage, lastAnalyzerResult : AnalyzeResult?) -> AnalyzeResult {
        
        debugPrintln("analyze called")
        let results = self.analyze(uiimage)
        debugPrintln("analyze finished")
        debugPrintln(results)
        var i = 0
        var cvView = CvView(frame: CGRectMake(0, 0, uiimage.size.width, uiimage.size.height), background: uiimage)
        for result: TMResult in results {
            debugPrintln("result.pai = \(result.pai.toString())")
            debugPrintln("result.place = \(result.place)")
            i += 1
            cvView.addRect(result.place)
        }
        debugPrintln("total analyze = \(i)")
        var debugView = cvView.imageFromView()
        
        return AnalyzeResult(resultList: results)
    }
        
    func analyze(target: UIImage) -> [TMResult] {
        var results: [TMResult] = []
        for pai in self.paiTypes {
            let matches: Array<AnyObject> = self.matcher.matchTarget(target, withTemplate: pai.toString())
            for match: AnyObject in matches {
                if let m = match as? MatcherResult {
                    results.append(TMResult(x: Int(m.x), y: Int(m.y), width: Int(m.width), height: Int(m.height), value: m.value, pai: pai))
                }
            }
        }
        return sortWithPlace(filter(select(results)))
    }
    
    func select(pais: [TMResult]) -> [TMResult] {
        var selected = [TMResult]()
        var sorted_pai = pais
        sort(&sorted_pai) { p1, p2 in return p1.value > p2.value }
        for pai: TMResult in sorted_pai {
            if let nearestPai = self.nearest(pai, paiList: selected) {
                if CGRectIntersectsRect(nearestPai.place, pai.place) {
                    let intersection: CGRect = CGRectIntersection(nearestPai.place, pai.place)
                    let ratio: CGFloat = (intersection.width * intersection.height) / (pai.place.width * pai.place.height)
                    if ratio > 0.15 {
                        if pai.value > nearestPai.value {
                            selected = selected.filter { $0 !== nearestPai }
                            selected.append(pai)
                        }
                    } else {
                        selected.append(pai)
                    }
                } else {
                    selected.append(pai)
                }
            } else {
                selected.append(pai)
            }
        }
        return selected
    }

    func filter(pais: [TMResult]) -> [TMResult] {
        if pais.count >= 14 {
            var filtered_pais = pais
            sort(&filtered_pais){ p1, p2 in return p1.value > p2.value }
            return filtered_pais[0..14]
        }
        return pais
    }
    
    func sortWithPlace(pais: [TMResult]) -> [TMResult] {
        var sorted_pais = pais
        sort(&sorted_pais){ p1, p2 in return p1.place.origin.x < p2.place.origin.x }
        return sorted_pais
    }
    
    func nearest(pai: TMResult, paiList: [TMResult]) -> TMResult? {
        var minDistance = Double.infinity
        var nearestPai: TMResult? = nil
        for p in paiList {
            let distance = pai.distance(p)
            if minDistance > distance {
                minDistance = distance
                nearestPai = p
            }
        }
        return nearestPai
    }
}

class AnalyzeResult {
    let resultList: [TMResult]
    let paiList: [Pai]
    init(resultList: [TMResult]) {
        self.resultList = resultList
        self.paiList = resultList.map{ $0.pai }
    }
    
    //牌のリスト。0番目は手牌の一番左
    func getPaiList() -> [Pai] {
        return paiList
    }
    
    //牌の位置(paiPositionIndex)を指定すると、その牌がある場所を長方形で返す
    func getPaiPositionRect(paiPositionIndex: Int) -> CGRect {
        return resultList[paiPositionIndex].place
    }
    
    //解析に成功した牌の数
    func getAnalyzeSuccessNum() -> Int {
        return resultList.count
    }

    //解析に成功したかどうか
    func isSuccess() -> Bool {
        return self.getAnalyzeSuccessNum() >= 14
    }
}
