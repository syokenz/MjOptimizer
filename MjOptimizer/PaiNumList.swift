//
//  PaiNumList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/12.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class PaiNum{
    var pai : Pai
    var num : Int
    init(pai:Pai,num:Int){self.pai = pai;self.num = num}
    func inc(){num++}
    public func toString()->String{return pai.type.toRaw() + String(pai.number) + "=" + String(num)}
    func copy()->PaiNum{return PaiNum(pai: self.pai,num: self.num)}
}

public class PaiNumList {
    public var list : [PaiNum] = [
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 7), num:0)
    ]
    public init(list:[PaiNum]){
        self.list = list
    }
    public init(paiList:[Pai]){
        for pai in paiList {
            for paiNum in self.list{
                if pai == paiNum.pai {
                    paiNum.inc()
                }
            }
        }
    }
    func copy() -> PaiNumList{
        var tmp : [PaiNum] = []
        for paiNum in self.list{
            tmp.append(paiNum.copy())
        }
        return PaiNumList(list: tmp)
    }
    //自身をコピーして、牌の数をnumだけ減らして、返す
    public func remove(pai : Pai,num : Int) -> PaiNumList?{
        var tmp : PaiNumList = self.copy()
        for paiNum in tmp.list{
            if pai == paiNum.pai {
                if paiNum.num < num{
                    return nil
                }else{
                    paiNum.num -= num
                }
            }
        }
        return tmp
    }
    //牌の枚数
    public func count() -> Int{
        var count = 0
        for paiNum in self.list{
            count += paiNum.num
        }
        return count
    }
    //index番目の要素を返す
    public func get(index:Int)->PaiNum{
        return self.list[index]
    }
    //引数paiの枚数を返す
    public func getNum(pai:Pai) -> Int{
        for paiNum in self.list{
            if paiNum.pai == pai {return paiNum.num}
        }
        return 0
    }
    //引数paiの枚数を一枚減らす
    public func decNum(pai:Pai){
        for paiNum in self.list{
            if paiNum.pai == pai {paiNum.num -= 1}
        }
    }
    //引数paiの枚数を一枚増やす
    public func incNum(pai:Pai){
        for paiNum in self.list{
            if paiNum.pai == pai {paiNum.num += 1}
        }
    }
    //paiの個数が0以上か？
    public func include(pai:Pai) -> Bool{
        return self.getNum(pai) > 0
    }
    //paiから始まるシュンツはあるか？
    public func includeShuntsuFrom(pai:Pai) -> Bool{
        return self.include(pai) && pai.next() != nil && self.include(pai.next()!) && pai.next(range: 2) != nil && self.include(pai.next(range: 2)!)
    }
    //paiからなるアンコウはあるか？
    public func includeAnkouOf(pai:Pai) -> Bool{
        return self.getNum(pai) >= 3
    }
    //paiからなるアンコウを削除したPaiNumListを返す
    public func removeAnkouOf(pai:Pai) -> PaiNumList?{
        var tmp : PaiNumList = self.copy()
        for paiNum in tmp.list{
            if pai == paiNum.pai {
                if paiNum.num < 3 {
                    return nil
                }else{
                    paiNum.num -= 3
                }
            }
        }
        return tmp
    }
    //paiから始まるシュンツを削除したPaiNumListを返す
    public func removeShuntsuFrom(pai:Pai) -> PaiNumList?{
        if(pai.type == PaiType.JIHAI || pai.number > 7){
            return nil
        }
        if self.getNum(pai) >= 1 && self.getNum(pai.next()!) >= 1 && self.getNum(pai.next(range:2)!) >= 1 {
            var tmp : PaiNumList = self.copy()
            tmp.decNum(pai)
            tmp.decNum(pai.next()!)
            tmp.decNum(pai.next(range:2)!)
            return tmp
        }else{
            return nil
        }
    }
    public func toString()->String{
        var str = ""
        for pn in list{
            if pn.num != 0 {
                str += pn.toString() + ","
            }
        }
        return str
    }
}