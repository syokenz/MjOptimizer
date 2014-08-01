//
//  Mentsu.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public enum MentsuType: Int{
    case TOITSU  = 1
    case CHI     = 2
    case SHUNTSU = 3
    case PON     = 4
    case ANKOU   = 5
    case MINKAN  = 6
    case ANKAN   = 7
    case SPECIAL = 8
    case ABSTRUCT = -1
}
protocol MentsuProtocol{
    func copy() -> Mentsu
    func identical() -> Pai
    func toString() -> String
    func fuNum() -> Int
    func isFuro() -> Bool//副露かどうか。面前の逆。アンカンも含む。
    func isMenzen() -> Bool//面前かどうか。副露の逆。アンカンは含まない。
    func isNaki() -> Bool//鳴いたかどうか。アンカンは含まない。
    func size() -> Int
    func type() -> MentsuType
    func include(pai:Pai) -> Bool
    func isChuchan() -> Bool
    func isYaochu() -> Bool
    func isJihai() -> Bool
    func paiType() -> PaiType
    func consistOfSamePai() -> Bool
    func consistOfDifferentPai() -> Bool
}
//親クラス
public class Mentsu: MentsuProtocol, Equatable, Comparable {
    //paiListをパースして適切なMentsuを生成する
    public class func parse(let paiList:[Pai]) -> Mentsu?{
        var pl = paiList
        sort(&pl,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isFuro { furoNum += 1 }
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
            if pai.isFuro {
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
    //文字列をパースして面子を作る
    public class func parseStr(paiStr:String) -> Mentsu?{
        let paiList = Pai.parseList(paiStr)
        if (paiList){
            return Mentsu.parse(paiList!)!
        }
        return nil
    }
    
    //この面子がツモ牌を含む場合はこの変数にツモ牌が入る
    public var tsumoPai:Pai? = nil

    //親クラスであるため、以下の関数が直接呼ばれることはない。値は全部ダミー
    public func copy() -> Mentsu {return self}
    public func identical() -> Pai { return PaiMaster.pais["j1t"]! }
    public func toString() -> String { return "Mentsu親クラス" }
    public func fuNum() -> Int { return -200 }
    public func isFuro() -> Bool { return false }
    public func isMenzen() -> Bool {return false}
    public func isNaki() -> Bool { return false }
    public func size() -> Int { return 0 }
    public func type() -> MentsuType { return MentsuType.ABSTRUCT }
    public func include(pai:Pai) ->Bool {return false}
    public func isChuchan() -> Bool { return false}
    public func isYaochu() -> Bool { return false}
    public func isJihai() -> Bool {return false}
    public func paiType() -> PaiType {return PaiType.MANZU}
    public func consistOfSamePai() -> Bool{return false}
    public func consistOfDifferentPai() -> Bool{return false}
}

public func == (lhs: Mentsu, rhs: Mentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical() && lhs.tsumoPai == rhs.tsumoPai
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
    override public func copy() -> Mentsu {return SamePaiMentsu(pai:pai)}
    override public func identical() ->Pai{ return self.pai }
    override public func toString() -> String{
        let str = super.tsumoPai ? "(ツモ" + tsumoPai!.toShortStr() + ")" : ""
        return pai.toShortStr() + str
    }
    override public func fuNum()->Int{return 0}
    override public func isFuro() -> Bool { return false }
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return false }
    override public func size()->Int{return 0}
    override public func type()->MentsuType{return MentsuType.ABSTRUCT}
    override public func include(pai:Pai)->Bool {return self.pai == pai}
    override public func isChuchan() -> Bool { return pai.isChuchan}
    override public func isYaochu() -> Bool { return pai.isYaochu}
    override public func isJihai() -> Bool {return pai.type == PaiType.JIHAI}
    override public func paiType() -> PaiType {return pai.type}
    override public func consistOfSamePai() -> Bool{return true}
    override public func consistOfDifferentPai() -> Bool{return false}
}
public func == (lhs: SamePaiMentsu, rhs: SamePaiMentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical() && lhs.tsumoPai == rhs.tsumoPai
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
    override public func copy() -> Mentsu {return ToitsuMentsu(pai:pai)}
    override public func toString() -> String{ return "トイツ:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func isMenzen() -> Bool {return true}
    override public func isNaki() -> Bool { return false }
    override public func size()->Int{return 2}
    override public func type()->MentsuType{return MentsuType.TOITSU}
}
//アンコウ
public class AnkouMentsu: SamePaiMentsu{
    override public func copy() -> Mentsu {return AnkouMentsu(pai:pai)}
    override public func toString() -> String{ return "アンコウ:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func isMenzen() -> Bool {return true}
    override public func isNaki() -> Bool { return false }
    override public func size()->Int{return 3}
    override public func type()->MentsuType{return MentsuType.ANKOU}
}
//ポン
public class PonMentsu: SamePaiMentsu{
    override public func copy() -> Mentsu {return PonMentsu(pai:pai)}
    override public func toString() -> String{ return "ポン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return true}
    override public func size()->Int{return 3}
    override public func type()->MentsuType{return MentsuType.PON}
}
//アンカン
public class AnkanMentsu: SamePaiMentsu{
    override public func copy() -> Mentsu {return AnkanMentsu(pai:pai)}
    override public func toString() -> String{ return "アンカン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return false}
    override public func size()->Int{return 4}
    override public func type()->MentsuType{return MentsuType.ANKOU}
}
//ミンカン
public class MinkanMentsu: SamePaiMentsu{
    override public func copy() -> Mentsu {return MinkanMentsu(pai:pai)}
    override public func toString() -> String{ return "ミンカン:" + super.toString() }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return true}
    override public func size()->Int{return 4}
    override public func type()->MentsuType{return MentsuType.MINKAN}
}

//異なる牌で構成される面子の親クラス
public class DifferentPaiMentsu: Mentsu,Equatable,Comparable{
    var paiList : [Pai]
    public init(paiList:[Pai]) {
        self.paiList = paiList
        sort(&self.paiList,<)
    }
    override public func copy() -> Mentsu {return DifferentPaiMentsu(paiList:paiList)}
    override public func identical() -> Pai{return self.paiList[0]}
    override public func toString() -> String{
        let str = super.tsumoPai ? "(ツモ" + tsumoPai!.toShortStr() + ")" : ""
        return join("",paiList.map({ $0.toShortStr()})) + str
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return false}
    override public func size()->Int{return paiList.count}
    override public func type()->MentsuType{return MentsuType.ABSTRUCT}
    override public func include(pai:Pai)->Bool {return paiList.any({$0 == pai})}
    override public func isChuchan() -> Bool {return paiList.all({$0.isChuchan})}
    override public func isYaochu() -> Bool {return paiList[0].number == 1 || paiList[2].number == 9}//123か789
    override public func isJihai() -> Bool {return false}
    override public func paiType() -> PaiType {return paiList[0].type}
    override public func consistOfSamePai() -> Bool{return false}
    override public func consistOfDifferentPai() -> Bool{return true}
}
public func == (lhs: DifferentPaiMentsu, rhs: DifferentPaiMentsu) -> Bool {
    return lhs.type() == rhs.type() && lhs.identical() == rhs.identical() && lhs.tsumoPai == rhs.tsumoPai
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
    override public func copy() -> Mentsu {return ShuntsuMentsu(paiList:paiList)}
    override public func toString() -> String{
        return "シュンツ:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func isMenzen() -> Bool {return true}
    override public func isNaki() -> Bool { return false}
    override public func type()->MentsuType{return MentsuType.SHUNTSU}
}
//チー
public class ChiMentsu: DifferentPaiMentsu{
    override public func copy() -> Mentsu {return ChiMentsu(paiList:paiList)}
    override public func toString() -> String{
        return "チー:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return true}
    override public func isMenzen() -> Bool {return false}
    override public func isNaki() -> Bool { return true}
    override public func type()->MentsuType{return MentsuType.CHI}
    //引数でチーが成立するか
    public class func isMadeFrom(let paiList: [Pai]) -> Bool{
        var pl = paiList
        sort(&pl,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isFuro { furoNum += 1 }
        }
        return furoNum == 1 && pl.count == 3 && pl[0].isNext(pl[1]) && pl[1].isNext(pl[2])
    }
}
//国士かシーサンプータ
public class SpecialMentsu: DifferentPaiMentsu{
    override public func copy() -> Mentsu {return SpecialMentsu(paiList:paiList)}
    override public func toString() -> String{
        return "特殊系:" + super.toString()
    }
    override public func fuNum()->Int{return 0}//TODO}
    override public func isFuro()->Bool{return false}
    override public func isMenzen() -> Bool {return true}
    override public func isNaki() -> Bool { return false}
    override public func type()->MentsuType{return MentsuType.SPECIAL}
}


