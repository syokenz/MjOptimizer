//
//  MentsuResolverSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/25.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//
//

import MjOptimizer
import Quick
import Nimble

class MentsuResolverSpec: QuickSpec {
    override func spec() {
        describe("furoResolve"){
            it("returns mentsu list 1"){
                let pl : [Pai] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj2tj2tj2l")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("ポン:j2"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            
            it("returns mentsu list 2"){
                let pl : [Pai] = Pai.parseList("m1tm1tp9tp9rp9tp9tp7lp7tp7tp7tp8tp8tp8tp8rm1lm2tm3t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("チー:m1m2m3"))
                    expect(mentsuList[1].toString()).to(equal("ミンカン:p8"))
                    expect(mentsuList[2].toString()).to(equal("ミンカン:p7"))
                    expect(mentsuList[3].toString()).to(equal("ミンカン:p9"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns mentsu list 3"){
                let pl : [Pai] = Pai.parseList("m1tm2tm3tp2tp2tp6lp7tp8tp8tp8lp8tp9tp9tp9r")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("ポン:p9"))
                    expect(mentsuList[1].toString()).to(equal("ポン:p8"))
                    expect(mentsuList[2].toString()).to(equal("チー:p6p7p8"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns mentsu list 4"){
                let pl : [Pai] = Pai.parseList("m1tm1ts7ts8ts9ts9rs9ts9tm1lm2tm3tm4lm5tm6t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("チー:m4m5m6"))
                    expect(mentsuList[1].toString()).to(equal("チー:m1m2m3"))
                    expect(mentsuList[2].toString()).to(equal("ポン:s9"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns mentsu list 5"){
                let pl : [Pai] = Pai.parseList("m1tm1tr0ts1ts1tr0ts7ls8ts9ts9rs9ts9tm4lm5tm6t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("チー:m4m5m6"))
                    expect(mentsuList[1].toString()).to(equal("ポン:s9"))
                    expect(mentsuList[2].toString()).to(equal("チー:s7s8s9"))
                    expect(mentsuList[3].toString()).to(equal("アンカン:s1"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns mentsu list 6"){
                let pl : [Pai] = Pai.parseList("s7ts8ts9ts9ts9tm4lm5tm6tr0ts2ts2tr0tm1lm1tm1t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("ポン:m1"))
                    expect(mentsuList[1].toString()).to(equal("アンカン:s2"))
                    expect(mentsuList[2].toString()).to(equal("チー:m4m5m6"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns mentsu list 7"){
                let pl : [Pai] = Pai.parseList("s7ts8ts9ts9ts9tm4lm5tm6tm1lm1tm1ts2tr0tr0ts2t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .SUCCESS(mentsuList):
                    expect(mentsuList[0].toString()).to(equal("アンカン:s2"))
                    expect(mentsuList[1].toString()).to(equal("ポン:m1"))
                    expect(mentsuList[2].toString()).to(equal("チー:m4m5m6"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns ERROR 1"){
                let pl : [Pai] = Pai.parseList("m1tm1ts8ts9ts9rs9ts9tm1lm2tm3tp8lp8tp8tp8t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .ERROR(mgs):
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns ERROR 2"){
                let pl : [Pai] = Pai.parseList("m1tm1tr0ts1tr0ts7ts8ts9ts9rs9ts9tm1lm2tm3t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .ERROR(mgs):
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("returns ERROR 3"){
                let pl : [Pai] = Pai.parseList("m1tm1ts7ts7ts7ts8ts8ts8ts9ts9ts9rp4tp5tp6t")!
                let frr : FuroResolveResult = MentsuResolver.furoResolve(pl)
                switch frr{
                case let .ERROR(mgs):
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
        }
        describe("getOneFuro"){
            it("gets pon"){
                let pl : [Pai] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj2tj2tj2l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:j2"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("gets chi"){
                let pl : [Pai] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tm1tm2lm3t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("チー:m1m2m3"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("345678(9)999 -> 345 678 (9)999"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("3456789(9)99 -> 345 678 9(9)99"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("34567899(9)9 -> 345 678 99(9)9"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("345678999(9) -> 345 678 999(9)"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            
            it("345678(9)99(9) -> 3456 78(9) 99(9)"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("34567(8)999(9) -> 3456 7(8)9 99(9)"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("3456(7)8999(9) -> 3456 (7)89 99(9)"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("345(6)78999(9) -> 345 (6)78 999(9)"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            
            it("345678(9)99(9) -> 3456 78(9) 9(9)9"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("34567(8)99(9)9 -> 3456 7(8)9 9(9)9"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("3456(7)899(9)9 -> 3456 (7)89 9(9)9"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("345(6)7899(9)9 -> 345 (6)78 99(9)9"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            
            it("345678(9)(9)99 -> 3456 78(9) (9)99"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("34567(8)9(9)99 -> 3456 7(8)9 (9)99"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("3456(7)89(9)99 -> 3456 (7)89 (9)99"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ポン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("345(6)789(9)99 -> 345 (6)78 9(9)99"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("ミンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            
            it("アンカン表裏裏表"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tr1tr1tp9t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("アンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
            it("アンカン裏表表裏"){
                let pl : [Pai] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tr1tp9tp9tr1t")!
                let getOneFuroResult : GetOneFuroResult = MentsuResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to(equal("アンカン:p9"))
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to(beTruthy())
                }
            }
        }

        describe("menzenResolve"){
            it("works1"){
                var paiList : [Pai] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9tm9tj1tj1t")!
                let mrr : MenzenResolveResult = MentsuResolver.menzenResolve(paiList)
                switch mrr{
                case let .SUCCESS(agariList):
                    expect(agariList.count).to(equal(1))
                    expect(agariList[0].tsumoPai.toString()).to(equal("j1t"))
                    expect(agariList[0].atama.toString()).to(equal("トイツ:j1"))
                    expect(agariList[0].mentsuList[0].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[0].mentsuList[1].toString()).to(equal("シュンツ:m4m5m6"))
                    expect(agariList[0].mentsuList[2].toString()).to(equal("シュンツ:m7m8m9"))
                    expect(agariList[0].mentsuList[3].toString()).to(equal("アンコウ:m9"))
                    expect(agariList[0].mentsuList[4].toString()).to(equal("トイツ:j1"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("works2"){
                var paiList : [Pai] = Pai.parseList("m1tm1tm1tm1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9t")!
                var mrr :MenzenResolveResult = MentsuResolver.menzenResolve(paiList)
                switch mrr{
                case let .SUCCESS(agariList):
                    expect(agariList[0].tsumoPai.toString()).to(equal("m9t"))
                    expect(agariList[0].atama.toString()).to(equal("トイツ:m9"))
                    expect(agariList[0].mentsuList[0].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[0].mentsuList[1].toString()).to(equal("アンコウ:m1"))
                    expect(agariList[0].mentsuList[2].toString()).to(equal("シュンツ:m4m5m6"))
                    expect(agariList[0].mentsuList[3].toString()).to(equal("シュンツ:m7m8m9"))
                    expect(agariList[0].mentsuList[4].toString()).to(equal("トイツ:m9"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("works3"){
                var paiList : [Pai] = Pai.parseList("m1tm1tm1tm1tm2tm2tm2tm2tm3tm3tm3tm3tm4tm4t")!
                var mrr : MenzenResolveResult = MentsuResolver.menzenResolve(paiList)
                switch mrr{
                case let .SUCCESS(agariList):
                    expect(agariList.count).to(equal(3))
                    expect(agariList[0].tsumoPai.toString()).to(equal("m4t"))
                    expect(agariList[0].atama.toString()).to(equal("トイツ:m1"))
                    expect(agariList[0].mentsuList[0].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[0].mentsuList[1].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[0].mentsuList[2].toString()).to(equal("シュンツ:m2m3m4"))
                    expect(agariList[0].mentsuList[3].toString()).to(equal("シュンツ:m2m3m4"))
                    expect(agariList[0].mentsuList[4].toString()).to(equal("トイツ:m1"))
                    expect(agariList[1].tsumoPai.toString()).to(equal("m4t"))
                    expect(agariList[1].atama.toString()).to(equal("トイツ:m4"))
                    expect(agariList[1].mentsuList[0].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[1].mentsuList[1].toString()).to(equal("アンコウ:m1"))
                    expect(agariList[1].mentsuList[2].toString()).to(equal("アンコウ:m2"))
                    expect(agariList[1].mentsuList[3].toString()).to(equal("アンコウ:m3"))
                    expect(agariList[1].mentsuList[4].toString()).to(equal("トイツ:m4"))
                    expect(agariList[2].tsumoPai.toString()).to(equal("m4t"))
                    expect(agariList[2].atama.toString()).to(equal("トイツ:m4"))
                    expect(agariList[2].mentsuList[0].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[2].mentsuList[1].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[2].mentsuList[2].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[2].mentsuList[3].toString()).to(equal("シュンツ:m1m2m3"))
                    expect(agariList[2].mentsuList[4].toString()).to(equal("トイツ:m4"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
        }
        
        
        describe("makeMentsuList"){
            it("return 1 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(1))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:アンコウ:m1"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return 1 shuntsu"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2tm3t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(1))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:シュンツ:m1m2m3"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return 2 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm2tm2t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(1))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:アンコウ:m1,アンコウ:m2"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return 1 shuntsu 1 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm1tm2tm3t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(1))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:シュンツ:m1m2m3,アンコウ:m1"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return 2 mentsu list"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm2tm2tm3tm3tm3t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(2))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:アンコウ:m1,アンコウ:m2,アンコウ:m3"))
                    expect(mentsuListList[1].toString()).to(equal("面子リスト:シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return 2 mentsu list"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm1t2tm2tm2tm2tm3tm3tm3tm3t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to(equal(2))
                    expect(mentsuListList[0].toString()).to(equal("面子リスト:シュンツ:m1m2m3,アンコウ:m3,アンコウ:m2,アンコウ:m1"))
                    expect(mentsuListList[1].toString()).to(equal("面子リスト:シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3"))
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return MakeMentsuResult.CONFLICT"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tm9tj1tj1t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .CONFLICT:
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return MakeMentsuResult.FINISH"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .FINISH:
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
            it("return MakeMentsuResult.ERROR"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2t")!)
                var mmr : MakeMentsuResult = MentsuResolver.makeMentsuList(pnl)
                switch mmr{
                case let .ERROR(msg):
                    expect(true).to(beTruthy())
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to(beTruthy())
                }
            }
        }
    }
}