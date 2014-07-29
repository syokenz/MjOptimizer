//
//  Mentsu.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class MentsuFactory{
    //paiListをパースして適切なMentsuを生成する
    public class func createMentsu(let paiList:[Pai]) -> Mentsu?{
        var pl = paiList
        sort(&pl,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isNaki() { furoNum += 1 }
        }
        var isFuro : Bool
        if furoNum == 0 {
            isFuro = false
        }else if furoNum == 1{
            isFuro = true
        }else{
            return nil
        }
        for pai in pl{
            if pai.isNaki() {
                isFuro = true
                break
            }
        }
        if(pl.count == 3 && pl[0].isNext(pl[1]) && pl[1].isNext(pl[2])){
            return isFuro ? ChiMentsu(paiList:pl) : ShuntsuMentsu(paiList:pl)
        }else if(pl.count == 2 && pl[0] == pl[1] && !isFuro){
            return ToitsuMentsu(pai: pl[0])
        }else if(pl.count == 3 && pl[0] == pl[1] && pl[1] == pl[2]){
            return isFuro ? PonMentsu(pai: pl[0]) : AnkouMentsu(pai: pl[0])
        }else if(pl.count == 4 && pl[0] == pl[1] && pl[1] == pl[2] && pl[2] == pl[3]){
            return isFuro ? MinkanMentsu(pai: pl[0]) : AnkanMentsu(pai: pl[0])
        }else if(pl.count == 14){
            return SpecialMentsu(paiList:pl)
        }else{
            return nil
        }
    }
    public class func isChi(let paiList: [Pai]) -> Bool{
        var pl = paiList
        sort(&pl,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isNaki() { furoNum += 1 }
        }
        return furoNum == 1 && pl.count == 3 && pl[0].isNext(pl[1]) && pl[1].isNext(pl[2])
    }
}

public enum MentsuType: Int{
    case Toitsu  = 1
    case Chi     = 2
    case Shuntsu = 3
    case Pon     = 4
    case Ankou   = 5
    case Minkan  = 6
    case Ankan   = 7
    case Special = 8
    case Abstruct = -1
}

public class Mentsu: Equatable, Comparable {
    public func identical() -> Pai { return Pai.parse("m1t")! }
    public func toString() -> String { return "Mentsu" }
    public func fuNum() -> Int { return -200 }
    public func isFuro() -> Bool { return false }
    public func size() -> Int { return 0 }
    public func type() -> MentsuType { return MentsuType.Abstruct }
}

public func == (lhs: Mentsu, rhs: Mentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical()
}
func != (lhs: Mentsu, rhs: Mentsu) -> Bool {
    return !(lhs == rhs)
}
public func < (lhs: Mentsu, rhs: Mentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() < rhs.type().toRaw()
    }else{
        return lhs.identical() < rhs.identical()
    }
}
public func > (lhs: Mentsu, rhs: Mentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() > rhs.type().toRaw()
    }else{
        return lhs.identical() > rhs.identical()
    }
}

//同じ牌で構成される面子の親クラス
public class SamePaiMentsu: Mentsu,Equatable,Comparable{
    var pai : Pai
    public init(pai:Pai){self.pai = pai}
    public init(paiList:[Pai]){self.pai = paiList[0]}
    override public func identical() ->Pai{ return self.pai }
    override public func toString() -> String{ return pai.type.toRaw() + String(pai.number) }
    override public func fuNum()->Int{return 0}
    override public func isFuro()->Bool{return false}
    override public func size()->Int{return 0}
    override public func type()->MentsuType{return MentsuType.Abstruct}
}
public func == (lhs: SamePaiMentsu, rhs: SamePaiMentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical()
}
func != (lhs: SamePaiMentsu, rhs: SamePaiMentsu) -> Bool {
    return !(lhs == rhs)
}
public func < (lhs: SamePaiMentsu, rhs: SamePaiMentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() < rhs.type().toRaw()
    }else{
        return lhs.identical() < rhs.identical()
    }
}
public func > (lhs: SamePaiMentsu, rhs: SamePaiMentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() > rhs.type().toRaw()
    }else{
        return lhs.identical() > rhs.identical()
    }
}

//トイツ
public class ToitsuMentsu: SamePaiMentsu{
    public init(pai: Pai) { return super.init(pai: pai) }
    override public func toString() -> String{ return "トイツ:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func size()->Int{return 2}
    override public func type()->MentsuType{return MentsuType.Toitsu}
}
//アンコウ
public class AnkouMentsu: SamePaiMentsu{
    override public func toString() -> String{ return "アンコウ:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func size()->Int{return 3}
    override public func type()->MentsuType{return MentsuType.Ankou}
}
//ポン
public class PonMentsu: SamePaiMentsu{
    override public func toString() -> String{ return "ポン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func size()->Int{return 3}
    override public func type()->MentsuType{return MentsuType.Pon}
}
//アンカン
public class AnkanMentsu: SamePaiMentsu{
    override public func toString() -> String{ return "アンカン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func size()->Int{return 4}
    override public func type()->MentsuType{return MentsuType.Ankan}
}
//ミンカン
public class MinkanMentsu: SamePaiMentsu{
    override public func toString() -> String{ return "ミンカン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func size()->Int{return 4}
    override public func type()->MentsuType{return MentsuType.Minkan}
}

//異なる牌で構成される面子の親クラス
public class DifferentPaiMentsu: Mentsu,Equatable,Comparable{
    var paiList : [Pai]
    public init(paiList:[Pai]) {
        self.paiList = paiList
        sort(&self.paiList,<)
    }
    override public func identical() -> Pai{return self.paiList[0]}
    override public func toString() -> String{
        var str: String = ""
        for pai in paiList{
            str += pai.type.toRaw() + String(pai.number)
        }
        return str
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func size()->Int{return paiList.count}
    override public func type()->MentsuType{return MentsuType.Abstruct}
}
public func == (lhs: DifferentPaiMentsu, rhs: DifferentPaiMentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical()
}
func != (lhs: DifferentPaiMentsu, rhs: DifferentPaiMentsu) -> Bool {
    return !(lhs == rhs)
}
public func < (lhs: DifferentPaiMentsu, rhs: DifferentPaiMentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() < rhs.type().toRaw()
    }else{
        return lhs.identical() < rhs.identical()
    }
}
public func > (lhs: DifferentPaiMentsu, rhs: DifferentPaiMentsu) -> Bool {
    if lhs.identical() == rhs.identical(){
        return lhs.type().toRaw() > rhs.type().toRaw()
    }else{
        return lhs.identical() > rhs.identical()
    }
}

//シュンツ
public class ShuntsuMentsu: DifferentPaiMentsu{
    public init(paiList: [Pai]) { return super.init(paiList: paiList) }
    override public func toString() -> String{
        return "シュンツ:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func type()->MentsuType{return MentsuType.Shuntsu}
}
//チー
public class ChiMentsu: DifferentPaiMentsu{
    override public func toString() -> String{
        return "チー:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func type()->MentsuType{return MentsuType.Chi}
}
//国士かシーサンプータ
public class SpecialMentsu: DifferentPaiMentsu{
    override public func toString() -> String{
        return "特殊系:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func type()->MentsuType{return MentsuType.Special}
}


