//
//  SutehaiCandidate.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

public class SutehaiCandidate {
    var pai: Pai //捨て牌
    var ukeirePaiList: [UkeirePai]
    var shantenNum: Int //この牌を捨てると何シャンテンになるか
    var positionIndex: Int //この捨て牌が手配の中で左から何番目か。0スタート
    var positionRect: CGRect? //画像の中での位置

    public init(pai:Pai,ukeirePaiList:[UkeirePai],shantenNum:Int,positionIndex:Int){
        self.pai = pai
        self.ukeirePaiList = ukeirePaiList
        self.shantenNum = shantenNum
        self.positionIndex = positionIndex
        self.positionRect = nil
    }
    //setter getter
    public func getPai() -> Pai {return self.pai}
    public func getUkeirePaiList() -> [UkeirePai]{return self.ukeirePaiList}
    public func getShantenNum() -> Int { return self.shantenNum}
    public func getPositionIndex() -> Int {return self.positionIndex}
    public func getPositionRect() -> CGRect? { return self.positionRect}
    public func setPositionRect(positionRect:CGRect){self.positionRect = positionRect}
    
    //この捨て牌で受け入れ枚数が合計で何枚になるか
    public func getUkeireTotalNum() -> Int{
        var sum: Int = 0
        for ukeirePai in self.ukeirePaiList{
            sum += ukeirePai.getRemainNum()
        }
        return sum
    }
    func getUkeirePaiToPaiList() -> [Pai] {
        var paiList: [Pai] = []
        for ukeirePai : UkeirePai in self.ukeirePaiList {
            paiList.append(ukeirePai.pai)
        }
        return paiList
    }
}
