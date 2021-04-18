//
//  ViewController.swift
//  avplayer
//
//  Created by Sean Wang on 2021/3/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    var player : AVPlayer?
    
    var bRec:Bool = false
    
    var timeN : Int = 100
    
    
    class sData : Codable
    {
        var result : result
    }
    class result : Codable
    {
        var videoInfo : videoInfo
    }
    class videoInfo : Codable
    {
        var captionResult : captionResult
    }
    class captionResult : Codable
    {
        var results : [results]
    }
    class results : Codable
    {
        var captions : [captions]
    }
    class captions : Codable
    {
        var content : String
        var time : Int
    }
    
    var myData : sData?
    
    @IBOutlet var avplayerButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.layer.addSublayer(self.layer)
        avplayerButton.imageView?.contentMode = .scaleAspectFit
        avplayerButton.setImage(UIImage(named: "download"), for: .normal)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        { (_) in
            
            
            if(self.player?.currentTime().seconds ?? 0 <= 2.5 && self.player?.currentTime().seconds ?? 0 >= 0 && self.timeN != 0)
                        {
                
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                
                self.timeN = 0
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 5.4 && self.player?.currentTime().seconds ?? 0 > 2.5 && self.timeN != 1)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
                            
                            self.timeN = 1
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 9.6 && self.player?.currentTime().seconds ?? 0 > 5.4 && self.timeN != 2)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 2, section: 0), at: .top, animated: true)
                            
                            self.timeN = 2
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 13.1 && self.player?.currentTime().seconds ?? 0 > 9.6 && self.timeN != 3)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 3, section: 0), at: .top, animated: true)
                            
                            self.timeN = 3
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 17.9 && self.player?.currentTime().seconds ?? 0 > 13.1 && self.timeN != 4)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 4, section: 0), at: .top, animated: true)
                            
                            self.timeN = 4
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 22 && self.player?.currentTime().seconds ?? 0 > 17.9 && self.timeN != 5)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 5, section: 0), at: .top, animated: true)
                            
                            self.timeN = 5
                        }
                        
                        
            if(self.player?.currentTime().seconds ?? 0 <= 23.4 && self.player?.currentTime().seconds ?? 0 > 22 && self.timeN != 6)
                        {
                            
                            self.tableView.reloadData()
                            
                            self.tableView.scrollToRow(at: IndexPath(item: 6, section: 0), at: .top, animated: true)
                            
                            self.timeN = 6
                        }
            
            
            if(self.player?.currentTime().seconds ?? 0 <= 28 && self.player?.currentTime().seconds ?? 0 > 23.4 && self.timeN != 7)
            {
                self.tableView.reloadData()
                self.timeN = 7
            }
            
            
            if(self.player?.currentTime().seconds ?? 0 <= 29.4 && self.player?.currentTime().seconds ?? 0 > 28 && self.timeN != 8)
            {
                self.tableView.reloadData()
                self.timeN = 8
            }
            
            
            if(self.player?.currentTime().seconds ?? 0 <= 33.7 && self.player?.currentTime().seconds ?? 0 > 29.4 && self.timeN != 9)
            {
                self.tableView.reloadData()
                self.timeN = 9
            }
            
            
            if(self.player?.currentTime().seconds ?? 0 > 33.7 && self.timeN != 10)
            {
                self.tableView.reloadData()
                self.timeN = 10
            }
            
            
            if(self.player?.currentTime().seconds ?? 0 >= 39)
            {
                let plarTime = CMTime(value: 0, timescale: 1)
                self.player?.seek(to: plarTime)
                self.bRec = false
                self.avplayerButton.setImage(UIImage(named: "download"), for: .normal)
                self.player?.pause()
            }
        }
        
        tableViewInit()
        
        let APIUrl = "https://api.italkutalk.com/api/video/detail";
        let url = URL(string: APIUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = ["guestKey" : "44f6cfed-b251-4952-b6ab-34de1a599ae4","videoID" : "5edfb3b04486bc1b20c2851a","mode" : 1] as [String : Any]
        let postString = try? JSONSerialization.data(withJSONObject: postData)
        request.httpBody = postString
        
        let task = URLSession.shared.dataTask(with: request)
                {
                    data, response,error in
                    if(error != nil)
                    {
                        print("發送失敗",error!.localizedDescription)
                    }
                    else
                    {
                        print("發送成功")
                        DispatchQueue.main.async
                        {
                            do
                            {
                                self.myData = try JSONDecoder().decode(sData.self, from: data!)
                                
                                self.tableView.reloadData()
                                
                            }
                            catch
                            {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                task.resume()
    }
    
    private lazy var layer : AVPlayerLayer =
        {
        let remoteURL = NSURL(string: "https://itutbox.s3.amazonaws.com/youtubeMP4/Online/5ee07d2e4486bc1b20c535bf%5bFriday%20Joke%5d%20A%20Woman%20Gets%20On%20A%20Bus%20-%20YouTube.mp4.mp4")
        self.player = AVPlayer(url: remoteURL! as URL)
        let layer = AVPlayerLayer(player: self.player)
        return layer
        }()
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        layer.frame = CGRect(x: 10, y: 0, width: 355, height: 270)
    }
    
    func tableViewInit()
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseCell")
        let cellNib = UINib(nibName: "myTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myTVC")
    }
    
    
    @IBAction func clickTest(_ sender: Any)
    {
        bRec = !bRec
            if bRec
            {
                avplayerButton.setImage(UIImage(named: "stop"), for: .normal)
                player?.play()
            }
            else
            {
                avplayerButton.setImage(UIImage(named: "download"), for: .normal)
                player?.pause()
            }
    }
    
}

extension ViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return myData?.result.videoInfo.captionResult.results[0].captions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTVC", for: indexPath) as! myTableViewCell
        let info = myData?.result.videoInfo.captionResult.results[0].captions[indexPath.row]
        cell.setCell(wordT: info?.content ?? "", numberT: indexPath.row + 1)
        
        if(indexPath.row == timeN)
        {
            cell.backgroundColor = UIColor.gray
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
}

extension ViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let timeV = Int(myData?.result.videoInfo.captionResult.results[0].captions[indexPath.row].time ?? 0)
        let playTime = CMTime(value: CMTimeValue(timeV), timescale: 1)
        player?.seek(to: playTime)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
