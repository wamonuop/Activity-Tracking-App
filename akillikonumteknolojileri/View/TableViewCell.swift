//
//  TableViewCell.swift
//  akillikonumteknolojileri
//
//  Created by Abdullah onur Şimşek on 28.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier : String = "tableViewCell"
    
    let rightDateLabel : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.textAlignment = .right
        x.font = UIFont(name: "Lato-Regular", size: 16)
       return x
    }()
    
    let mainView : UIView = {
       let x = UIView()
        x.layer.cornerRadius = 5
        x.layer.masksToBounds = true
        x.backgroundColor = .white
        x.layer.shadowColor = UIColor.black.cgColor
        x.layer.shadowOpacity = 0.3
        x.layer.shadowOffset = CGSize(width: 0, height: 0)
        x.layer.shadowRadius = 5
        x.clipsToBounds = false
       return x
    }()
    
    let rightImageView : UIImageView = {
       let x = UIImageView()
        x.contentMode = .scaleToFill
       return x
    }()
    let activityCount : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 22)
        x.backgroundColor = .clear
       return x
    }()
    let activityStartLabel : UILabel = {
       let x = UILabel()
        x.font = UIFont(name: "Lato-Bold", size: 12)
        x.text = "Started At"
        x.textColor = .lightGray
        x.textAlignment = .center
       return x
    }()
    let activityStartDate : UILabel = {
       let x = UILabel()
        x.textAlignment = .center
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Regular", size: 16)
       return x
    }()
    let activityfinishedLabel : UILabel = {
       let x = UILabel()
        x.font = UIFont(name: "Lato-Bold", size: 12)
        x.text = "Finished At"
        x.textColor = .lightGray
        x.textAlignment = .center
       return x
    }()
    let activityFinishDate : UILabel = {
       let x = UILabel()
        x.textAlignment = .center
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Regular", size: 16)
       return x
    }()
    let activityDistanceLabel : UILabel = {
        let x = UILabel()
        x.font = UIFont(name: "Lato-Bold", size: 12)
        x.text = "Distance Travelled"
        x.textColor = .lightGray
        x.textAlignment = .center
        return x
    }()
    let activityDistance : UILabel = {
        let x = UILabel()
        x.textAlignment = .center
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Regular", size: 16)
        return x
    }()
    let activitySpeedLabel : UILabel = {
        let x = UILabel()
        x.font = UIFont(name: "Lato-Bold", size: 12)
        x.text = "Average Speed"
        x.textColor = .lightGray
        x.textAlignment = .center
        return x
    }()
    let activityAverageSpeed : UILabel = {
       let x = UILabel()
        x.textAlignment = .center
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Regular", size: 16)
       return x
    }()
    
     override func awakeFromNib() {
         super.awakeFromNib()
  
     }
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
     }
     required init?(coder: NSCoder) {
         fatalError()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
        mainView.frame = CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40, height: 160)
        mainView.addSubview(rightImageView)
        mainView.addSubview(activityCount)
        mainView.addSubview(activityStartLabel)
        mainView.addSubview(activityStartDate)
        mainView.addSubview(activityfinishedLabel)
        mainView.addSubview(activityFinishDate)
        mainView.addSubview(activitySpeedLabel)
        mainView.addSubview(activityAverageSpeed)
        mainView.addSubview(activityDistanceLabel)
        mainView.addSubview(activityDistance)
        mainView.addSubview(rightDateLabel)

        activityCount.frame = CGRect(x: 10, y: 10, width: 200, height: 30)
        activityStartLabel.frame = CGRect(x: 10, y: activityCount.frame.maxY + 5, width: 120, height: 20)
        activityStartDate.frame = CGRect(x: 10, y: activityStartLabel.frame.maxY, width: 120, height: 22)
        activityfinishedLabel.frame = CGRect(x: activityStartLabel.frame.maxX + 10, y: activityCount.frame.maxY + 5, width: 120, height: 20)
        activityFinishDate.frame = CGRect(x: activityfinishedLabel.frame.minX, y: activityfinishedLabel.frame.maxY , width: 120, height: 22)
        activitySpeedLabel.frame = CGRect(x: 10, y: activityStartDate.frame.maxY + 5, width: 120, height: 20)
        activityAverageSpeed.frame = CGRect(x: 10, y: activitySpeedLabel.frame.maxY + 5, width: 120, height: 22)
        activityDistanceLabel.frame = CGRect(x: activitySpeedLabel.frame.maxX + 10, y: activitySpeedLabel.frame.minY, width: 120, height: 20)
        activityDistance.frame = CGRect(x: activitySpeedLabel.frame.maxX + 10, y: activityDistanceLabel.frame.maxY + 5, width: 120, height: 22)
        rightDateLabel.frame = CGRect(x: mainView.frame.width-120, y: 13, width: 100, height: 30)
        rightImageView.frame = CGRect(x: mainView.frame.maxX - 100, y:rightDateLabel.frame.maxY + 25, width: 50, height: 50)
     }
     
     override func prepareForReuse() {
         super.prepareForReuse()
     }


}


