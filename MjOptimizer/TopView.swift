//
//  TopView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

class TopView:UIView{
    var captureDevice: AVCaptureDevice!
    var captureView : CaptureView = CaptureView()
    let startButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton

    //局状態の変数
    let kyoku = Kyoku()//起動時はデフォルトの局状態で計算し、局に局状態を更新する

    override init(){
        super.init(frame:CGRectMake(0, 0, 480, 320))
        
        //captureView
        self.captureView.setTopView(self)
        self.addSubview(self.captureView)
        
        //startButton
        startButton.frame = CGRectMake(0, 0, 200, 100)
        startButton.setTitle("START SCAN...", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(startButton)
        
        
        
        if findCamera() {
            self.captureView.captureInit(captureDevice)
        }else{
            //カメラがないのでテスト画面を出す
            Log.info("カメラがないからテスト画面を出す")
            let scoreCalcResult :ScoreCalcResult =  ScoreCalculator.calcFromStr("m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l", kyoku: Kyoku())
            switch scoreCalcResult{
            case let .SUCCESS(score):
                Log.info("hoge")
                //TODO
//                self.addSubview(
//                    ScoreView(
//                        score:score,
//                        paiList:Pai.parseList("m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l")!
//                    )
//                )
            case let .ERROR(msg):
                Log.error(msg)
            }
        }
    }
    
    //スタートボタンを押したときの挙動
    func startButtonDidPush() {
        self.captureView.startCapture()
    }
    
    //画像解析が終わったときにコールバックされる
    func showResult(paiList:[Pai],capturedImage:UIImage){
        //得点計算
        let scoreCalcResult :ScoreCalcResult = ScoreCalculator.calc(paiList, kyoku: self.kyoku)
        switch scoreCalcResult{
        case let .SUCCESS(score):
            self.addSubview(ScoreView(score:score,paiList:paiList,capturedImage:capturedImage))
        case let .ERROR(msg):
            //得点計算に失敗
            Log.info(msg)
        }
    }
    
    
    //カメラが見つかろうかどうか
    private func findCamera() -> Bool {
        let devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if (captureDevice != nil) {
            // Debug
            Log.info("Success finding Camera")
            Log.info("Camera name = " + captureDevice!.localizedName)
            Log.info(captureDevice!.modelID)
            return true
        } else {
            Log.info("Missing Camera")
            return false
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}